class HomeController < ApplicationController

	def root

		if current_user
			redirect_to dashboard_url
		else
			redirect_to home_url
		end

	end
end
