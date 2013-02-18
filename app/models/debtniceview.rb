class Debtniceview < ActiveRecord::Base
  attr_accessible :creditor_id, :debitor_id, :value
end
