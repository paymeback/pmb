class DebitorValidator < ActiveModel::Validator
  def validate(record)
      if record.debitor_id != ""
	if (!User.exists?(record.debitor_id))
		record.errors[:Debitor] << 'not found'
	end
      end
  end
end
