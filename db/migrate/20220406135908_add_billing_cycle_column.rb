class AddBillingCycleColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :workflow_runs, :billing_cycle, :string
  end
end
