json.extract! workflow_job, :id, :status, :runner_id, :labels, :minutes, :workflow_name, :repo, :org, :sender, :created_at, :updated_at
json.url workflow_job_url(workflow_job, format: :json)
