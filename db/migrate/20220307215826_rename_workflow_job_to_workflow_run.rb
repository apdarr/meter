class RenameWorkflowJobToWorkflowRun < ActiveRecord::Migration[6.1]
  def change
    rename_table :workflow_jobs, :workflow_runs
  end
end
