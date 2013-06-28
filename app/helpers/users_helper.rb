module UsersHelper


	def check_invite(invitecode)

		if InviteCode.where(:code => invitecode, :used => false).count > 0
			return true
		else
			return false
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
end
