module LocationHelper

  	def vendor_location_id_matches
  		if current_user.bus_vendor.id == Location.find(params[:id]).bus_vendor_id
  			return true
  		else
  			return false
  		end
  	end

  	def vendor_can_delete_featured_item

  		if current_user.bus_vendor.id == Location.find(params[:location_id]).bus_vendor_id
  			return true
  		else
  			return false
  		end
  	end
end
