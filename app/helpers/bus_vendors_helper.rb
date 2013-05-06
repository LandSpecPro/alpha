module BusVendorsHelper

	def get_static_map_from_address(address)
		staticmap = "http://maps.googleapis.com/maps/api/staticmap?markers=" + address + "&size=150x100&maptype=roadmap&sensor=false"
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

end
