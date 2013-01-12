class Debt < ActiveRecord::Base
  #belongs_to :user
  belongs_to :debitor, :class_name => "User", :foreign_key => 'debitor_id'
  belongs_to :creditor, :class_name => "User", :foreign_key => 'creditor_id'
  attr_accessible :cleared, :creditor_id, :debitor_id, :description, :value, :confirmed
end
