module BusVendorsHelper

	def get_static_map_from_address(address)
		staticmap = "http://maps.googleapis.com/maps/api/staticmap?markers=" + address + "&size=750x200&maptype=roadmap&sensor=false"
		return staticmap
	end

	def get_map_link_from_address(address)
		maplink = "http://maps.google.com/?q=" + address + " "
		return maplink
	end

	def concat_address(loc)
		address = loc.address1 + " " + loc.address2 + " " + loc.city + " " + loc.state + " " + loc.zip
		return address
	end

	def concat_unclaimed_address(loc)
		address = loc.loc_address1 + " " + loc.loc_address2 + " " + loc.loc_city + " " + loc.loc_state + " " + loc.loc_zip
		return address
	end

end
