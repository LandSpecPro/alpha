class AccountController < ApplicationController
	before_filter :require_user
	before_filter :require_business

	def manage

		if current_user.is_vendor
			redirect_to supplier_account_url(:password_update_success => params[:password_update_success], :success => params[:success])
		elsif current_user.is_buyer
			redirect_to buyer_account_url(:password_update_success => params[:password_update_success], :success => params[:success])
		else
			redirect_to home_url
		end

	end

	def manage_company

		if current_user.is_vendor
			redirect_to supplier_company_url
		elsif current_user.is_buyer
			redirect_to buyer_company_url
		else
			redirect_to home_url
		end

	end

	def update
		redirect_to home_url

	end

end
