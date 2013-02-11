class AddBillToDebt < ActiveRecord::Migration
  def change
    add_column :debts, :bill, :binary
  end
end
