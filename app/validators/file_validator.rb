class FileValidator < ActiveModel::Validator
  def validate(record)
	if record.bill != nil
		if (record.bill.size/(1000*1000) > 5)
			record.errors[:bill] << '- Only files up to 5 MB are allowed'
		end 
		c = record.bill_type
		h = { "a" => "image/jpg", "b" => "image/png", "c" => "image/jpeg", "d" => 				"application/pdf"}
		if !(h.has_value?(c))
			record.errors[:bill_type] << '- Not supported content type'
		end
	end
  end
end
