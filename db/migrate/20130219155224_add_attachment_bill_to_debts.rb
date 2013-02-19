class AddAttachmentBillToDebts < ActiveRecord::Migration
  def self.up
    change_table :debts do |t|
      t.attachment :bill
    end
  end

  def self.down
    drop_attached_file :debts, :bill
  end
end
