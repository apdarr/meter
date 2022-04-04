class CreateWorkflowJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :workflow_runs do |t|
      t.string :status
      t.integer :runner_id
      t.string :labels
      t.integer :minutes
      t.string :workflow_name
      t.string :repo
      t.string :org
      t.string :sender

      t.timestamps
    end
  end
end
