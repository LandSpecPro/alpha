module LocationHelper

    def require_location_active_unless_owner
      loc = Location.find(params[:id])
      if not loc.active
        if not loc.is_owner(current_user)
          redirect_to main_url
        end
      end
    end

  	def require_business_location_matches
      if current_user.user_detail.id != Location.find(params[:id]).user_detail_id
  			redirect_to locations_manage_url
        return false
  		end
  	end

  	def require_business_featured_item_matches

  		if current_user.user_detail.id != Location.find(params[:location_id]).user_detail_id
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

    def get_static_map_from_address(address)
      staticmap = "http://maps.googleapis.com/maps/api/staticmap?markers=" + address + "&size=750x200&maptype=roadmap&sensor=false&key={AIzaSyBGSTtn0qJVuX30ZLet1Q39O-bVg4soYZI}"
      return staticmap
    end

    def get_static_map_custom(address, width, height)
      staticmap = "http://maps.googleapis.com/maps/api/staticmap?markers=" + address + "&size=" + width + "x" + height + "&maptype=roadmap&sensor=false&key=AIzaSyBGSTtn0qJVuX30ZLet1Q39O-bVg4soYZI"
      return staticmap
    end

    def get_map_link_from_address(address)
      maplink = "http://maps.google.com/?q=" + address + " "
      return maplink
    end

    def concat_address(loc)
      unless loc.address2.blank?
        address = loc.address1 + " " + loc.address2 + " " + loc.city + " " + loc.state + " " + loc.zip
      else
        address = loc.address1 + " " + loc.city + " " + loc.state + " " + loc.zip
      end
      return address
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

      unless UserDetail.find(location.user_detail_id).tagline.blank?
        @weight = @weight + 5
      end

      unless location.bio.blank?
        @weight = @weight + 8
      end

      unless UserDetail.find(location.user_detail_id).logo_file_name.blank?
        @weight = @weight + 12
      end

      unless FeaturedItem.where(:location_id => location.id).count == 0
        @weight = @weight + 15
      end

      location.searchWeight = @weight
      location.save
    end

    

end
