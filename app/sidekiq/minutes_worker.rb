class MinutesWorkerJob
  include Sidekiq::Job
  include WorkflowRunsHelper

  def perform

    
    # If we're in the current cycle, update all minutes
    WorkflowRun.where(billing_cycle: current_billing_interval).each do |workflow_run|

      # We're using this API endpoint /repos/{owner}/{repo}/actions/workflows/{workflow_id}/timing to get the minutes of each workflow_run
      response = HTTParty.get("http://api.github.com/repos/#{workflow_run.repo_owner}/#{workflow_run.repo}/actions/workflows/#{workflow_run.workflow_id}/timing", {
      :headers => {"Accept" => "application/vnd.github.v3+json","Authorization" => "token #{ENV['GH_TOKEN']}"}
      }).to_hash
        
      # Loop through each runtime environment and calculate the total minutes consumed
      # Todo: calculate multipler if Windows or macOS  
      minutes = 0
      response["billable"].each do |key, value|
        #minutes += value["total_ms"] / 60000
        minutes += value["total_ms"]
      end
      WorkflowRun.update(minutes: minutes)
    end
  end
end
