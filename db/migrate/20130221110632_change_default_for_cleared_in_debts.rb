class ChangeDefaultForClearedInDebts < ActiveRecord::Migration
  def up
	change_column :debts, :cleared, :boolean, :default => false
  end

  def down
	change_column :debts, :cleared, :boolean
  end
end
