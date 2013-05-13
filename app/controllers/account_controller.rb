class AccountController < ApplicationController
	before_filter :require_user
	before_filter :require_business

	def manage

		if current_user.is_vendor
			redirect_to business_vendor_manage_url
		elsif current_user.is_buyer
			redirect_to business_buyer_manage_url
		else
			redirect_to home_url
		end

	end

	def update
		redirect_to home_url

	end

end
