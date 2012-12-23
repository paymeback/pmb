class AddColumnConfirmedToDebt < ActiveRecord::Migration
  def change
    add_column :debts, :confirmed, :boolean
  end
end
