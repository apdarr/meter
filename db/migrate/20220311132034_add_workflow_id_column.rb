class AddWorkflowIdColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :workflow_runs, :workflow_id, :integer
  end
end
