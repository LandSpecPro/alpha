module UsersHelper

	def is_missing_terms(terms)
		if not params[:terms]
	    	return true
	    else
	    	return false
	    end
	end

	def is_confirm_email_wrong(email, confirmemail)
		if email == confirmemail
			return false
		else
			return true
		end
	end

end
