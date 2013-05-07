class BusVendorsController < ApplicationController
	include BusVendorsHelper
	before_filter :require_user
	before_filter :require_user_is_vendor
	before_filter :require_business, :except => [:new, :create]

	def new
		@no_company = params[:no_company]
		@user = current_user
		@busvendor = current_user.build_bus_vendor
	end

	def create
		@user = current_user
		@busvendor = @user.create_bus_vendor(params[:bus_vendor])

		# Update current_users Business-Vendor id
		@user.update_attribute(:bus_vendor_id, @busvendor.id)

	    if @busvendor.save
	      flash[:notice] = "Account registered!"
	      redirect_to business_vendor_dashboard_url
	    else
	      flash[:notice] = "Not successful!"
	      render :action => :new
	    end
	end

	def manage
		@user = current_user
	end

	def manage_account
		@user = current_user
		@view = 'manage_account'
		@usertype = "N/A"
		if @user.is_vendor
			@usertype = "Vendor"
		elsif @user.is_buyer
			@usertype = "Buyer"
		end
		render 'manage'
	end

	def manage_locations
		@user = current_user
		@view = 'manage_locations'
		@staticmapaddress = "http://maps.googleapis.com/maps/api/staticmap"
		render 'manage'
	end

	def new_location
		@user = current_user
		@view = 'new_location'
		@location = Location.new
		render 'manage'
	end

	def edit_location
		@user = current_user
		@view = 'edit_location'
		@location = Location.find(params[:id])
		if @user.bus_vendor.id != @location.bus_vendor_id
			redirect_to business_vendor_locations_manage_url
		else
			render 'manage'
		end
	end

	def show
		@vendors = BusVendor.all
	end

end
