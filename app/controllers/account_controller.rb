class AccountController < ApplicationController
	before_filter :require_user
	before_filter :require_business
	
	def view
		@user = current_user
	end

	def edit
	end

end
