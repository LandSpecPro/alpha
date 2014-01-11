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
	  		#@userdetail.user = current_user
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
	end

end
