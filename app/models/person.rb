class Person < ActiveRecord::Base
  attr_accessible :first_name, :group_id, :last_name, :mail, :nickname
end
