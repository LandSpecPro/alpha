class AccountController < ApplicationController
	before_filter :require_user
	before_filter :require_business

	def manage
		@user = current_user
		@usertype = "N/A"
		if @user.is_vendor
			@usertype = "Vendor"
		elsif @user.is_buyer
			@usertype = "Buyer"
		end
	end

end
