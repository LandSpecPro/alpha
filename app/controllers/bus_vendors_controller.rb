class BusVendorsController < ApplicationController
	include BusVendorsHelper
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

	      redirect_to locations_new_url(:new_user_message => true)
	    else
	      flash[:notice] = "Not successful!"
	      render :action => :new
	    end
	end

	def update
		@busvendor = BusVendor.find(params[:id])
	    if @busvendor.update_attributes(params[:logo])
	      flash[:notice] = "Account updated!"
	      redirect_back_or_default('/') 
	    else
	      render :action => :manage
	    end

	end

	def manage
		store_location
		@user = current_user
		@bus_vendor = @user.bus_vendor
		@usertype = "Vendor"
	end

	def show
		@vendors = BusVendor.where(:active => true)
	end

	def edit

	end

	def dashboard
		@user = current_user
	end

	def help

	end
end
