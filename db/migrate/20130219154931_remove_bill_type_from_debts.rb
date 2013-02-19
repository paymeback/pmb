class RemoveBillTypeFromDebts < ActiveRecord::Migration
  def up
    remove_column :debts, :bill_type
  end

  def down
    add_column :debts, :bill_type, :string
  end
end
