class RemoveColumnFromPerson < ActiveRecord::Migration
  def up
    remove_column :people, :group_id
  end

  def down
    add_column :people, :group_id, :integer
  end
end
