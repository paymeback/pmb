class AddExpirationDateToDebts < ActiveRecord::Migration
  def change
    add_column :debts, :ex_date, :date
  end
end
