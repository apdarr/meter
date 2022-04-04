class RemoveStatusColumn < ActiveRecord::Migration[6.1]
  def change
    remove_column :workflow_runs, :status
  end
end
