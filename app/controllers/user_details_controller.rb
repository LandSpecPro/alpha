class UserDetailsController < ApplicationController

	include UserDetailHelper
	include ApplicationHelper

	before_filter :require_user
	before_filter :require_user_email_validated
	before_filter :require_no_user_details, :only => [:new, :create]
  
  	def new
  		@userdetail = UserDetail.new
  	end

  	def create
  		@userdetail = UserDetail.new(params[:user_detail])

  		verify_fields(params[:user_detail])

	  	if @userdetail.errors.count > 0
	  		render :action => :new
	  		return
	  	else
	  		@userdetail.user_type = current_user.userType
	  		if @userdetail.save
	  			current_user.user_detail = @userdetail

	  			if is_production_site
	  				Mailers.new_user_activation_email(current_user).deliver
	  			end

	  			if @userdetail.user_type == STRING_SUPPLIER
	  				unless current_user.verified
	  					Mailers.welcome_supplier_email(current_user.email, @userdetail.first_name, @userdetail.last_name, @userdetail.company_name).deliver
	  				end
	  				redirect_to locations_new_url
	  				return
	  			elsif @userdetail.user_type == STRING_BUYER
	  				unless current_user.verified
	  					Mailers.welcome_buyer_email(current_user.email, @userdetail.first_name, @userdetail.last_name, @userdetail.company_name).deliver
	  				end
	  				redirect_to help_url
	  				return
	  			end
	  		else
	  			render :action => :new
	  			return
	  		end
	  	end

	  	#TODO: Redirect to where it's supposed to go after creating user details for the first time
	  	redirect_to main_url
	end

	def edit

		if current_user.user_detail.blank?
			redirect_to user_details_new_url(:missing_details => true)
			return
		end

		@userdetail = current_user.user_detail
	end

	def update
		@userdetail = current_user.user_detail

  		verify_fields(params[:user_detail])

	  	if @userdetail.errors.count > 0
	  		temporarily_set_user_detail_fields(params[:user_detail])
	  		render :action => :edit
	  		return
	  	else
	  		@userdetail = current_user.user_detail
	  		if @userdetail.update_attributes(params[:user_detail])
	  			current_user.user_detail = @userdetail
	  			redirect_to user_details_edit_url(:success => true)
	  			return
	  		else
	  			render :action => :edit
	  			return
	  		end
	  	end

	end

end
