module UsersHelper


	def is_invite_wrong(invitecode)

		if invitecode.blank? or invitecode == ''
			return true
		end

		if InviteCode.where(:code => invitecode, :used => false).count > 0
			return false
		else
			return true
		end
	end

	def update_invite(user, invitecode)

		@invitecode = InviteCode.where(:code => invitecode, :used => false).first
		@invitecode.user_id = user.id
		@invitecode.used = true
		if @invitecode.save
			return true
		else
			return false
		end
	end

	def is_missing_terms(terms)
		if not params[:terms]
	    	return true
	    else
	    	return false
	    end
	end

	def is_confirm_email_wrong(email, confirmemail)
		if email == confirmemail
			return false
		else
			return true
		end
	end

  	def claim_user(claimprofile)
		@user = User.new(params[:user])
	    @user.userType = claimprofile.user_type

	    if @user.save
	    	if @user.userType == 'Vendor'
	      		claim_bus_vendor(@user, claimprofile)
	      	elsif @user.userType == 'Buyer'
	      		claim_bus_buyer(@user, claimprofile)
	      	end
	    else

	      return false
	    end
	 end

	 def claim_bus_buyer(user, claimprofile)
	 	@busbuyer = user.build_bus_buyer(:busName => claimprofile.bus_name, :busPhone => @phone)

	 	if @busbuyer.save
	 		user.bus_buyer_id = @busbuyer.id
	 		if user.save
	 			return true
	 		else
	 			user.destroy
	 			@busbuyer.destroy
	 			return false
	 		end
	 	else
	 		user.destroy
	 		return false
	 	end
	 end

	 def claim_bus_vendor(user, claimlocation)
	    @busvendor = user.build_bus_vendor(:busName => claimlocation.bus_name, :busPhone => claimlocation.loc_phone)    
	    
	    if @busvendor.save
	      user.bus_vendor_id = @busvendor.id
	      user.save
	      claim_location(user, claimlocation, @busvendor)
	    else
	      user.destroy
	      return false
	    end

	 end

	 def claim_location(user, claimlocation, busvendor)
	    @cl = claimlocation
	    @location = Location.new()
	    busvendor.locations.create(:address1 => @cl.loc_address1, :address2 => @cl.loc_address2, :city => @cl.loc_city, :state => @cl.loc_state, :zip => @cl.loc_zip, :primaryPhone => @cl.loc_phone, :busName => @cl.bus_name, :websiteLink => @cl.loc_website, :bus_vendor_id => user.bus_vendor_id)

	    if not busvendor.save
	      user.destroy
	      busvendor.destroy
	      return false
	    else
	      return true
	    end

	 end

end
