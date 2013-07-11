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

end
