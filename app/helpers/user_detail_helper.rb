module UserDetailHelper

	def verify_fields(par)
		if par[:first_name].length == 0 and current_user.is_buyer
	  		@userdetail.errors.add(:first_name, "First Name is required!")
	  	end

	  	if par[:last_name].length == 0 and current_user.is_buyer
	  		@userdetail.errors.add(:last_name, "Last Name is required!")
	  	end

	  	if par[:company_name].length == 0 and current_user.is_supplier
	  		@userdetail.errors.add(:company_name, "Company Name is required!")
	  	end

	  	if par[:phone_number].length == 0
	  		@userdetail.errors.add(:phone_number, "A valid phone number is required!")
	  	end
	end

	def temporarily_set_user_detail_fields(par)
		@userdetail.first_name = par[:first_name]
		@userdetail.last_name = par[:last_name]
		@userdetail.company_name = par[:company_name]
		@userdetail.phone_number = par[:phone_number]
		@userdetail.city = par[:city]
		@userdetail.state = par[:state]
		@userdetail.zip = par[:zip]
		@userdetail.user_category = par[:user_category]
	end

end
