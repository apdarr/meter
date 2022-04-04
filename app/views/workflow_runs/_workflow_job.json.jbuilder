json.extract! workflow_run, :id, :status, :runner_id, :labels, :minutes, :workflow_name, :repo, :org, :sender, :created_at, :updated_at
json.url workflow_run_url(workflow_run, format: :json)
