class FollowersController < ApplicationController

	def create
		if Follow.where(:user_id => current_user.id, :location_id => params[:location_id]).count == 0
			@follow = Follow.new(:user_id => current_user.id, :location_id => params[:location_id])

			if @follow.save
				#TODO: Show success message?
				redirect_back_or_default('/')
			else
				redirect_to oops_url
			end
		else
			@follow = Follow.where(:user_id => current_user.id, :location_id => params[:location_id]).first
			@follow.active = true
			if @follow.save
				#TODO: Show success message?
				redirect_back_or_default('/')
			else
				redirect_to oops_url
			end
		end
	end

	def delete
		if Follow.where(:user_id => current_user.id, :location_id => params[:location_id]).count > 0
			@follow = Follow.where(:user_id => current_user.id, :location_id => params[:location_id]).first
			@follow.active = false
			if @follow.save
				#TODO: Show success message?
				redirect_back_or_default('/')
			else
				redirect_to oops_url
			end
		else
			redirect_to oops_url
		end
	end
end
