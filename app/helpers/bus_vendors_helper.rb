module BusVendorsHelper

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

	def concat_unclaimed_address(loc)
		
		unless loc.loc_address2.blank?
			address = loc.loc_address1 + " " + loc.loc_address2 + " " + loc.loc_city + " " + loc.loc_state + " " + loc.loc_zip
		else
			address = loc.loc_address1 + " " + loc.loc_city + " " + loc.loc_state + " " + loc.loc_zip
		end

		return address
	end

end
