module CustomerioHelper

	def cio_user_new(user)

		if user.is_vendor
			@usertype = "Supplier"
		elsif user.is_buyer
			@usertype = "Buyer"
		else
			@usertype = "N/A"
		end

		$customerio.identify(
			id: user.id,
			email: user.email,
			username: user.login,
			created_at: format_datetime_or_return_blank(user.created_at, nil),
			created_at_timestamp: format_as_unix_timestamp(user.created_at),
			updated_at: format_datetime_or_return_blank(user.updated_at, nil),
			updated_at_timestamp: format_as_unix_timestamp(user.updated_at),
			login_count: user.login_count,
			last_login_at: format_datetime_or_return_blank(user.last_login_at, nil),
			last_login_ip: user.last_login_ip,
			current_login_ip: user.current_login_ip,
			user_is_verified: user.verified,
			user_type: @usertype
		)

	end

	def cio_user_login(user)

		$customerio.identify(
			id: user.id,
			login_count: user.login_count,
			last_login_at: format_datetime_or_return_blank(user.last_login_at, nil),
			last_login_ip: user.last_login_ip,
			current_login_ip: user.current_login_ip,
			user_is_verified: user.verified
		)

	end

	def format_datetime_or_return_blank(datetime, format)
		if datetime.blank?
			return ""
		elsif format.blank?
			return datetime.strftime("%B %d, %Y - %I:%M%p")
		else
			return datetime.strftime(format)
		end
	end

	def format_as_unix_timestamp(datetime)
		if datetime.blank?
			return ""
		else
			return datetime.to_i
		end
	end

end