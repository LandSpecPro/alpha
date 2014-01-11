module UserDetailHelper

	def verify_fields(first_name, last_name, company_name)
		if first_name.length == 0 and current_user.is_buyer
	  		@userdetail.errors.add(:first_name, "First Name is required!")
	  	end

	  	if last_name.length == 0 and current_user.is_buyer
	  		@userdetail.errors.add(:last_name, "Last Name is required!")
	  	end

	  	if company_name.length == 0 and current_user.is_vendor
	  		@userdetail.errors.add(:company_name, "Company Name is required!")
	  	end
	end

end
