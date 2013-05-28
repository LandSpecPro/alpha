module LocationHelper

  	def require_business_location_matches
  		if current_user.bus_vendor.id != Location.find(params[:id]).bus_vendor_id
  			redirect_to locations_manage_url
        return false
  		end
  	end

  	def require_business_featured_item_matches

  		if current_user.bus_vendor.id != Location.find(params[:location_id]).bus_vendor_id
        redirect_to locations_manage_url
  			return false
  		end
  	end

    def require_location_id

      if not params[:id]
        redirect_to locations_manage_url
        return
      else #if there is an id passed in
        if Location.where(:id => params[:id], :active => true).count == 0
          redirect_to locations_manage_url
          return
        end
      end

    end
end
