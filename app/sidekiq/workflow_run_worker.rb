class WorkflowRunWorker
  include Sidekiq::Job
  include WorkflowRunsHelper

  def perform(workflow_run_params)
    # The ID of the workflow itself 
    workflow_id = workflow_run_params.dig("workflow_run", "id")
    byebug
    # If the WorkflowRun doesn't exist, create a new record in the database
    if !WorkflowRun.exists?(workflow_id: workflow_id)
      # Name of workflow
      workflow_name = workflow_run_params.dig("workflow_run", "name")
      # Repo name where it was run
      repo_full_name = workflow_run_params.dig("repository", "full_name")
      # Who owns the repo for bill back purposes
      repo_owner = workflow_run_params.dig("repository", "owner", "login")
      # The person that initiated the workflow
      actor = workflow_run_params.dig("workflow_run", "triggering_actor", "login")     
      # If the workflow run already exists, do nothing. Else, insert a new row. 
      WorkflowRun.create(workflow_name: workflow_name, repo: repo_full_name, repo_owner: repo_owner, sender: actor, workflow_id: workflow_id, billing_cycle: current_billing_interval)
    #If the WorkflowRun exists, but a new billing cycle has started, create a new record  
    elsif WorkflowRun.find_by(workflow_id: workflow_id).billing_cycle != current_billing_interval 
      WorkflowRun.create(workflow_name: workflow_name, repo: repo_full_name, repo_owner: repo_owner, sender: actor, workflow_id: workflow_id, billing_cycle: current_billing_interval)
    else
      puts "workflow run already exists in this billing cycle" 
    end 
  end
end

