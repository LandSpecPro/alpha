module ProductHelper

	def require_id_parameter
### HERE REDIRECT ERROR MESSAGE BASED ON PROBLEM
		if params[:id].blank?
			redirect_to locations_manage_url # ERROR PAGE - DONT REDIRECT HOME
			return false
		else
			return true
		end
	end		

end
