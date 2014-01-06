module FollowersHelper

	def register_if_not_logged_in
		unless current_user
			redirect_to register_url(:alert => "require_register_to_follow")
		end
	end

end