class RemoveConfirmedFromDebts < ActiveRecord::Migration
  def up
    remove_column :debts, :confirmed
  end

  def down
    add_column :debts, :confirmed, :boolean
  end
end
