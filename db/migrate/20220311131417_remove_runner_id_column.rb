class RemoveRunnerIdColumn < ActiveRecord::Migration[6.1]
  def change
    remove_column :workflow_runs, :runner_id
  end
end
