class BusVendorsController < ApplicationController
	before_filter :require_user

	def new
		@bus_vendor = BusVendor.new
	end

	def create
	    @bus_vendor = BusVendor.new(params[:bus_vendor])
	    if @bus_vendor.save
	      flash[:notice] = "Account registered!"
	      redirect_to business_vendor_show_url
	    else
	      flash[:notice] = "Not successful!"
	      render :action => :new
	    end
	end

	def show
		@vendors = BusVendor.all
	end

end
