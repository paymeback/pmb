class DateValidator < ActiveModel::Validator
  def validate(record)
		if record.ex_date != nil
			if record.ex_date < Date.today
				record.errors[:expiration_date] << 'can not be in the past'
			end
		end
   end
end
