class HomeController < ApplicationController

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
	
end
