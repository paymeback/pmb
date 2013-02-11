class Debt < ActiveRecord::Base
  include ActiveModel::Validations

  belongs_to :debitor, :class_name => "User", :foreign_key => 'debitor_id'
  belongs_to :creditor, :class_name => "User", :foreign_key => 'creditor_id'
       attr_accessible :bill,:bill_type,:cleared, :creditor_id, :debitor_id, :description, :value, :confirmed
  validates :debitor_id,:creditor_id,:value, :presence => true
  #validates file
  validates_with FileValidator
  validates_with DebitorValidator
end
