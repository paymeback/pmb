class CreateUsergroups < ActiveRecord::Migration
  def change
    create_table :usergroups do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
