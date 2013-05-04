class AccountController < ApplicationController
	before_filter :require_user
	before_filter :require_business
	
	def view
		@user = current_user
	end

	def edit
	end

	def search_cat
		@user = current_user
		@user.search_logs << SearchLog.create(:searchTerm => "Cats")
		@user.save

		redirect_to account_view_url
	end

	def search
		@user = current_user
		@searchTerm = params[:search]
		@user.search_logs << SearchLog.create(@searchTerm)
		@user.save

		redirect_to account_view_url
	end

end
