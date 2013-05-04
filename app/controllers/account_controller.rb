class AccountController < ApplicationController
	before_filter :require_user
	before_filter :require_business
	
	def view
		@user = current_user
	end

	def edit
	end

	def search
		@user = current_user
		@user.search_logs << SearchLog.create(:searchTerm => params[:searchfor])
		@user.save

		redirect_to account_view_url
	end

	def newloc
		if current_user.is_vendor
			@business = current_user.bus_vendor
			@business.locations << Location.create(:bus_vendor_id => @business.id, :locName => "Location 1", :primaryPhone => "7707577583", :address1 => "500 Northside Circle NW", :address2 => "Apt. E4", :city => "Atlanta", :state => "Georgia", :zip => "30309", :primaryEmail => "jmatt306@gmail.com")
			@business.save
		end

		redirect_to account_view_url
	end

end
