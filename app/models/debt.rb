class Debt < ActiveRecord::Base
  belongs_to :user
  attr_accessible :cleared, :creditor_id, :debitor_id, :description, :value, :confirmed
end
