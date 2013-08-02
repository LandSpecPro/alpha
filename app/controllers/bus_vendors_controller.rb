class BusVendorsController < ApplicationController
	include BusVendorsHelper
	include CustomerioHelper
	before_filter :require_user
	before_filter :require_user_is_vendor
	before_filter :require_business, :except => [:new, :create]

	def new
		@no_company = params[:no_company]
		@user = current_user
		@busvendor = @user.build_bus_vendor
	end

	def create
		@user = current_user
		@busvendor = @user.build_bus_vendor(params[:bus_vendor])

	    if @busvendor.save
	      flash[:notice] = "Account registered!" 

	      

	      # Update current_users Business-Vendor id
		  @user.update_attribute(:bus_vendor_id, @busvendor.id)
		  cio_user_company(@user)

	      redirect_to locations_new_url(:new_user_message => true)
	    else
	      flash[:notice] = "Not successful!"
	      render :action => :new
	    end
	end

	def update
		@bus_vendor = BusVendor.find(params[:bus_vendor][:id])
	    if @bus_vendor.update_attributes(params[:bus_vendor])
	      flash[:notice] = "Account updated!"
	      @success = true
	      cio_user_company(current_user)
	      render :action => :manage_company
	    else
	      render :action => :manage_company
	    end
	end

	def manage
		store_location
		@user = current_user
		@bus_vendor = @user.bus_vendor
		@usertype = "Vendor"
	end

	def manage_company
		store_location
		@user = current_user
		@bus_vendor = @user.bus_vendor
		@usertype = "Vendor"
	end

	def help

	end
end
