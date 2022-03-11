class WorkflowRunWorker
  include Sidekiq::Job
=begin
  Rename model, file to WorkflowRun and WorkflowRunWorker

  In the params, we just need 
  1. the workflow ID from the workflow_run webhook event: https://docs.github.com/en/enterprise-cloud@latest/developers/webhooks-and-events/webhooks/webhook-events-and-payloads#workflow_run
  2. The repo name 
  3. The org name 
  4. The sender name

  Taking this data from Sidekiq, using the his workflow_id we use HTTParty to call this endpoint
  https://docs.github.com/en/enterprise-cloud@latest/rest/reference/actions#get-workflow-usage
  This will give us the usage minutes. Create new entry to save for existing one 
=end

  def perform(workflow_run_params)
    # Name of workflow
    name = workflow_run_params.dig("workflow_run", "name")

    # Repo name where it was run
    repo_name = workflow_run_params.dig("repository", "name")

    # Who owns the repo for bill back purposes
    repo_owner = workflow_run_params.dig("repository", "owner", "login")

    # The person that initiated the workflow
    actor = workflow_run_params.dig("workflow_run", "triggering_actor", "login")

    # The ID of the workflow itself 
    workflow_id = workflow_run_params.dig("workflow", "id")

    # Let the job complete, will eventually run this on schedule to update all workflow IDs, find their billing
    #sleep(15)

    #/repos/{owner}/{repo}/actions/workflows/{workflow_id}/timing

    response = HTTParty.get("http://api.github.com/repos/#{repo_owner}/#{repo_name}/actions/workflows/#{workflow_id}/timing", {
      :headers => {"Accept" => "application/vnd.github.v3+json","Authorization" => "token #{ENV['GH_TOKEN']}"}
      }).to_hash
    
    response["billable"].each do |key, value|
      tot += value[:total_ms]
    end   
    
    # To-do: update the schema
    # Save the items to the database
    WorkflowRun.create(workflow_name: name, repo: repo_name, org: repo_owner, sender: actor, minutes: tot, workflow_id: workflow_id)

  end
end

