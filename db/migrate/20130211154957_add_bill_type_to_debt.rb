class AddBillTypeToDebt < ActiveRecord::Migration
  def change
    add_column :debts, :bill_type, :string
  end
end
