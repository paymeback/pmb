class Debt < ActiveRecord::Base
  include ActiveModel::Validations

  belongs_to :debitor, :class_name => "User", :foreign_key => 'debitor_id'
  belongs_to :creditor, :class_name => "User", :foreign_key => 'creditor_id'
       attr_accessible :bill,:cleared, :creditor_id, :debitor_id, :description, :value, :confirmed
  has_attached_file :bill
  validates :debitor_id,:value, :presence => true
  validates_attachment :bill, :presence => true,
  :content_type => { :content_type => ["image/jpg","image/png","image/jpeg","application/pdf"] },
  :size => { :in => 0..500.kilobytes }

  #validates_with DebitorValidator
end
