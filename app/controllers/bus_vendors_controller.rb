class BusVendorsController < ApplicationController
	before_filter :require_user
	before_filter :require_user_is_vendor
	before_filter :require_business, :only => [:show]
	before_filter :require_no_business, :only => [:new, :create]

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
	      redirect_to account_url
	    else
	      flash[:notice] = "Not successful!"
	      render :action => :new
	    end
	end

	def manage

	end

	def show
		@vendors = BusVendor.all
	end

	def account_edit

	end

	def profile_edit

	end

end
