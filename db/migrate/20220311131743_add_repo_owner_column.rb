class AddRepoOwnerColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :workflow_runs, :repo_owner, :string
  end
end
