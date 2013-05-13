class BusBuyersController < ApplicationController
	before_filter :require_user
	before_filter :require_user_is_buyer
	before_filter :require_business, :except => [:new, :create]

	def new
		@no_company = params[:no_company]
		@user = current_user
		@busbuyer = current_user.build_bus_buyer
	end

	def create
		@user = current_user
		@busbuyer = @user.create_bus_buyer(params[:bus_buyer])

		# Update current_users Business-Buyer id
		@user.update_attribute(:bus_buyer_id, @busbuyer.id)

	    if @busbuyer.save
	      flash[:notice] = "Account registered!"
	      redirect_to business_buyer_dashboard_url
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
		@buyers = BusBuyer.all
	end

	def dashboard
		@user = current_user
	end

end
