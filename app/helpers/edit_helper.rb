module EditHelper

	#THIS IS HOW I SHOULD DO THINGS FROM NOW ON. USE HELPERS FOR THINGS LIKE THIS. I WANT TO REDO EVERYTHING NOW!!!!!
	def get_username
		return current_user.login
	end

end