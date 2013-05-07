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

	def show
		@buyers = BusBuyer.all
	end

	def account_edit

	end

	def profile_edit

	end
end
