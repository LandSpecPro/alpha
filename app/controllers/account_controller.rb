class AccountController < ApplicationController
	before_filter :require_user
	before_filter :require_business

	def manage

		if current_user.is_vendor
			redirect_to supplier_manage_url(:password_update_success => true)
		elsif current_user.is_buyer
			redirect_to buyer_manage_url(:password_update_success => true)
		else
			redirect_to home_url
		end

	end

	def update
		redirect_to home_url

	end

end
