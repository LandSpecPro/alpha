module AdminHelper

    def require_user_id
    	if params[:id].blank?
    		redirect_back_or_default("/")
    	end
    end

end
