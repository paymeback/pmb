class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :nickname
      t.string :last_name
      t.string :first_name
      t.string :mail
      t.integer :group_id

      t.timestamps
    end
  end
end
