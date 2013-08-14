module CustomerioHelper

	# For now these should only be done if the user is a vendor

	def cio_user_new(user)

		if user.is_vendor
			$customerio.identify(
				id: user.id,
				email: user.email,
				username: user.login,
				created_at: format_as_unix_timestamp(user.created_at),
				updated_at: format_as_unix_timestamp(user.updated_at),
				login_count: user.login_count,
				last_login_at: format_as_unix_timestamp(user.last_login_at),
				user_is_verified: user.verified,
				user_type: "Supplier"
			)
		end

	end

	def cio_user_login(user)

		if user.is_vendor
			$customerio.identify(
				id: user.id,
				email: user.email,
				username: user.login,
				login_count: user.login_count,
				last_login_at: format_as_unix_timestamp(user.last_login_at),
				last_login_ip: user.last_login_ip,
				current_login_ip: user.current_login_ip,
				user_is_verified: user.verified
			)
		end

	end

	def cio_user_update(user)

		if user.is_vendor
			$customerio.identify(
				id: user.id,
				email: user.email,
				username: user.login,
				last_updated_account_at: format_as_unix_timestamp(Time.now)
			)
		end

	end

	def cio_user_company(user)

		if user.is_vendor

			@busvendor = BusVendor.find(user.bus_vendor_id)

			if @busvendor.logo.blank?
				@haslogo = false
			else
				@haslogo = true
			end

			if @busvendor.tagline.blank?
				@hastagline = false
			else
				@hastagline = true
			end

			$customerio.identify(
				id: user.id,
				email: user.email,
				username: user.login,
				business_name: @busvendor.busName,
				business_has_tagline: @hastagline,
				business_has_logo: @haslogo,
				business_created_at: format_as_unix_timestamp(@busvendor.created_at),
				business_updated_at: format_as_unix_timestamp(@busvendor.updated_at),
				business_phone: @busvendor.busPhone,
				business_is_verified: @busvendor.verified,
				business_is_active: @busvendor.active
			)
		end

	end

	def cio_user_location(user, location)

		if user.is_vendor

			if user.bus_vendor.locations.count > 1
				cio_user_multiple_locations(user)
			else

				if location.bio.blank?
					@hasabout = false
				else
					@hasabout = true
				end

				if CategoryToLocation.where(:location_id => location.id).count == 0
					@hascategories = false
				else
					@hascategories = true
				end

				$customerio.identify(
					id: user.id,
					email: user.email,
					username: user.login,
					location_has_about_info: @hasabout,
					location_has_categories: @hascategories,
					location_active_featured_items_count: location.featured_items.where(:active => true).count,
					location_total_featured_items_added: location.featured_items.count,
					location_updated_at: format_as_unix_timestamp(location.updated_at),
					location_created_at: format_as_unix_timestamp(location.created_at),
					location_is_active: location.active,
					location_is_verified: location.verified,
					location_search_weight: location.searchWeight
				)

				if location.featured_items.where(:active => true).count > 0
					$customerio.identify(
						id: user.id,
						featured_items_last_added_at: format_as_unix_timestamp(location.featured_items.where(:active => true).order('created_at DESC').first.created_at),
						featured_items_last_updated_at: format_as_unix_timestamp(location.featured_items.where(:active => true).order('updated_at DESC').first.updated_at)
					)
				end
			end

		end

	end

	def cio_user_multiple_locations(user)

		## NEED TO ADD IN MORE HERE

		$customerio.identify(
			id: user.id,
			email: user.email,
			username: user.login,
			has_multiple_locations: true,
			business_number_of_locations: user.bus_vendor.locations.count,
			locations_last_added_at: format_as_unix_timestamp(user.bus_vendor.locations.order('created_at DESC').first.created_at),
			locations_last_updated_at: format_as_unix_timestamp(user.bus_vendor.locations.order('updated_at DESC').first.updated_at),
			location_has_about_info: nil,
			location_has_categories: nil,
			location_active_featured_items_count: nil,
			location_total_featured_items_added: nil,
			location_updated_at: nil,
			location_created_at: nil,
			location_is_active: nil,
			location_is_verified: nil,
			location_search_weight: nil
		)

	end

	def cio_user_public_profile(user, location)

		# This will not work exactly right for users with multiple locations
		if user.is_vendor

			$customerio.identify(
				id: user.id,
				email: user.email,
				username: user.login,
				public_url: location.public_url,
				public_url_active: location.public_url_active
			)

		end

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