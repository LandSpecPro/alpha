module AdminHelper

	def format_datetime_or_return_blank(datetime, format)
		if datetime.blank?
			return ""
		elsif format.blank?
			return datetime.strftime("%B %d, %Y - %I:%M %p")
        else
            return datetime.strftime(format)
        end
    end

    def require_user_id
    	if params[:id].blank?
    		redirect_back_or_default("/")
    	end
    end

end
