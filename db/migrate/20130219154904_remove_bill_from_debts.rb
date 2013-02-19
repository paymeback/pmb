class RemoveBillFromDebts < ActiveRecord::Migration
  def up
    remove_column :debts, :bill
  end

  def down
    add_column :debts, :bill, :binary
  end
end
