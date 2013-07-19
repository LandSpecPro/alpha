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

    def require_location_id_active

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

    def require_location_id
      if not params[:id]
        redirect_to locations_manage_url
        return
      else #if there is an id passed in
        if Location.where(:id => params[:id]).count == 0
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

    def update_weight_rank(location)

      # 5 points for tagline, each link, and email
      # 8 points for about section
      # 12 points for company logo
      # 15 points for having at least one featured item

      @weight = 0

      unless location.primaryEmail.blank?
        @weight = @weight + 5
      end

      unless location.websiteLink.blank?
        @weight = @weight + 5
      end

      unless location.facebookLink.blank?
        @weight = @weight + 5
      end

      unless location.twitterLink.blank?
        @weight = @weight + 5
      end

      unless location.googleLink.blank?
        @weight = @weight + 5
      end

      unless BusVendor.find(location.bus_vendor_id).tagline.blank?
        @weight = @weight + 5
      end

      unless location.bio.blank?
        @weight = @weight + 8
      end

      unless BusVendor.find(location.bus_vendor_id).logo_file_name.blank?
        @weight = @weight + 12
      end

      unless FeaturedItem.where(:location_id => location.id).count == 0
        @weight = @weight + 15
      end

      location.searchWeight = @weight
      location.save
    end

    

end
