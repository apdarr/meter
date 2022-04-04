class RemoveOrgColumn < ActiveRecord::Migration[6.1]
  def change
    remove_column :workflow_runs, :org
  end
end
