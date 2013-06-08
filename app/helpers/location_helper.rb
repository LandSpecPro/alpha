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

    def update_search_log

    @cats = ''

    if not params[:categories].nil?
      params[:categories].each do |c|
        @cats = @cats + Category.find(c).category + " "
      end
    end

    @searchlog = SearchLog.new(:searchTerm => params[:search], :user_id => current_user.id, :currentState => current_user.currentState, :currentCity => current_user.currentCity, :distanceFrom => params[:distance_from], :searchType => 'location', :categories => @cats)
    @searchlog.save

  end

end
