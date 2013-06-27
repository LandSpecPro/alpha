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

	def contact

	end

	def contact_submit

		contact = Feedback.new
		contact.email = params[:email]
		contact.type = params[:type]
		contact.subject = params[:subject]
		contact.body = params[:body]
		contact.save

		redirect_to contact_url(:submitted => true)

	end

	def subscribe_user
		

	end

	def subscribe

		@email = params[:emailnewsletter]

		pe = Newsletteremail.new
		pe.email = @email
		pe.save
		
		redirect_to home_url(:subscribed => true)
	end
	
end
