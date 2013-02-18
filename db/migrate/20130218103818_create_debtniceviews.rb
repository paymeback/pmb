class CreateDebtniceviews < ActiveRecord::Migration
  def change
    create_table :debtniceviews do |t|
      t.float :value
      t.integer :debitor_id
      t.integer :creditor_id

      t.timestamps
    end
  end
end
