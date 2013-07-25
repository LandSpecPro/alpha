class BusBuyersController < ApplicationController
	before_filter :require_user
	before_filter :require_user_is_buyer
	before_filter :require_business, :except => [:new, :create]
	before_filter :require_no_business, :only => [:new, :create]

	def new
		@no_company = params[:no_company]
		@user = current_user
		@busbuyer = @user.build_bus_buyer
	end

	def create
		@user = current_user
		@busbuyer = @user.build_bus_buyer(params[:bus_buyer])

	    if @busbuyer.save
	      flash[:notice] = "Account registered!"

	      # Update current_users Business-Buyer id
	      @user.update_attribute(:bus_buyer_id, @busbuyer.id)

	      redirect_to buyer_dashboard_url
	    else
	      flash[:notice] = "Not successful!"
	      render :action => :new
	    end
	end

	def manage
		store_location
		@user = current_user
		@bus_buyer = @user.bus_buyer
		@usertype = "Buyer"
	end

	def show
		@buyers = BusBuyer.where(:active => true)
	end

	def dashboard
		@user = current_user
	end

	def help

	end

end
