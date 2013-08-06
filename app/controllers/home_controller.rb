class HomeController < ApplicationController

	include CustomerioHelper
	
	def root

		if current_user
			if current_user.is_vendor
				redirect_to locations_manage_url
			else
				redirect_to products_search_url
			end
		else
			redirect_to home_url
		end

	end

	def terms

	end

	def contact

	end

	def contact_submit

		Mailers.feedback_email(params[:type], params[:email], params[:subject], params[:body]).deliver

		redirect_to contact_url(:submitted => true)

	end

	def feedback_success


  	end

	def subscribe_user
		

	end

	def subscribe

		@email = params[:emailnewsletter]

		pe = NewsletterEmail.new
		pe.email = @email
		pe.save
		
		redirect_to home_url(:subscribed => true)
	end

	def oops

		@message = lookup_err_code(params[:err_code])

		if params[:origin_url]
			@back_url = params[:origin_url]
		else
			@back_url = home_url
		end
	end

	private 
	def lookup_err_code(err_code)

		# INCORRECT LINK TO PUBLIC PROFILE
		if err_code == '1'
			return "The profile you were trying to get too doesn't exist. Check your spelling or the source to make sure everything is correct. If you feel like you've reached this page in error, feel free to contact us and we'll try to sort out this problem for you."
		# TOO MANY FEATURED ITEMS
		elsif err_code == '3'
			return "Oops! It seems you're trying to add more than three featured items. You can only have three per location at the moment. If this isn't the case, go back and try again. Sorry!"
		# WHEN SAVING TO DATABASE, SOMETHING WENT WRONG
		elsif err_code =='7'
			return "Don't panic! Something went wrong, but it'll be okay, go back and try again. And if that doesn't work let us know and we'll try to fix it."
		# BROKEN LINK
		elsif err_code == '19'
			return "The link you used doesn't seem to be working properly."
		# CLAIM PROFILE ERROR
		elsif err_code == '20'
			return "It looks like we can\'t find the profile you\'re looking for."
		# CREATED USER TYPE WAS NOT BUYER OR SUPPLIER
		elsif err_code == '185'
			return "Well that's our mistake. Something went wrong behind the scenes and we couldn't create your account. We'll do our best to fix it!"
		else
			return nil
		end

	end
	
end
