class UserDetailsController < ApplicationController

	include UserDetailHelper
  
  	def new
  		@userdetail = UserDetail.new
  	end

  	def create
  		@userdetail = UserDetail.new(params[:user_detail])

  		verify_fields(params[:user_detail][:first_name], params[:user_detail][:last_name], params[:user_detail][:company_name])

	  	if @userdetail.errors.count > 0
	  		render :action => :new
	  		return
	  	else
	  		if @userdetail.save
	  			current_user.user_detail = @userdetail
	  			redirect_to main_url
	  			return
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
