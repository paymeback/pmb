class CreateDebts < ActiveRecord::Migration
  def change
    create_table :debts do |t|
      t.float :value
      t.text :description
      t.integer :debitor_id
      t.integer :creditor_id
      t.boolean :cleared

      t.timestamps
    end
  end
end
