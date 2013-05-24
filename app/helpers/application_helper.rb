module ApplicationHelper

	def get_states
		return [
			['Alabama', 'AL'],
			['Alaska', 'AK'],
			['Arizona', 'AZ'],
			['Arkansas', 'AR'],
			['California', 'CA'],
			['Colorado', 'CO'],
			['Connecticut', 'CT'],
			['Delaware', 'DE'],
			['Florida', 'FL'],
			['Georgia', 'GA'],
			['Hawaii', 'HI'],
			['Idaho', 'ID'],
			['Illinois', 'IL'],
			['Indiana', 'IN'],
			['Iowa', 'IA'],
			['Kansas', 'KS'],
			['Kentucky', 'KY'],
			['Louisiana', 'LA'],
			['Maine', 'ME'],
			['Maryland', 'MD'],
			['Massachusetts', 'MA'],
			['Michigan', 'MI'],
			['Minnesota', 'MN'],
			['Mississippi', 'MS'],
			['Missouri', 'MO'],
			['Montana', 'MT'],
			['Nebraska', 'NE'],
			['Nevada', 'NV'],
			['New Hampshire', 'NH'],
			['New Jersey', 'NJ'],
			['New Mexico', 'NM'],
			['New York', 'NY'],
			['North Carolina', 'NC'],
			['North Dakota', 'ND'],
			['Ohio', 'OH'],
			['Oklahoma', 'OK'],
			['Oregon', 'OR'],
			['Pennsylvania', 'PA'],
			['Rhode Island', 'RI'],
			['South Carolina', 'SC'],
			['South Dakota', 'SD'],
			['Tennessee', 'TN'],
			['Texas', 'TX'],
			['Utah', 'UT'],
			['Vermont', 'VT'],
			['Virginia', 'VA'],
			['Washington', 'WA'],
			['West Virginia', 'WV'],
			['Wisconsin', 'WI'],
			['Wyoming', 'WY']
		]
	end

	def get_page_title
		if controller.controller_name == 'account'
			return "Account"
		elsif controller.action_name == 'search'
			return "Search"
		elsif controller.controller_name == 'locations' and controller.action_name == 'edit'
			return "Edit Location"
		elsif controller.controller_name == 'locations'
			return "Locations"
		elsif controller.controller_name == 'bus_vendors' and controller.action_name == 'manage'
			return "Account Management"
		elsif controller.controller_name == 'bus_buyers' and controller.action_name == 'manage'
			return "Account Management"
		elsif controller.controller_name == 'products'
			return "Products"
		elsif controller.controller_name == 'users' and controller.action_name == 'password_reset'
			return "Password Reset"
		elsif controller.controller_name == 'favorites'
			return "Favorites"
		else
			return ""
		end
	end

	def get_page_subtitle
		if controller.controller_name == 'locations'
			if controller.action_name == 'manage'
				return " Manage your locations"
			elsif controller.action_name == 'new'
				return " Add a new location"
			elsif controller.action_name == 'destroy'
				return " Delete this location?"
			elsif  controller.action_name == 'edit'
				return get_location_name
			elsif controller.action_name == 'search'
				return " for Vendors"
			else
				return ""
			end
		elsif controller.controller_name == 'products'
			if controller.action_name == 'browseall'
				return " Browse All"
			elsif controller.action_name == 'search'
				return " for Products"
			else
				return ""
			end
		elsif controller.controller_name == 'favorites'
			if controller.action_name == 'products'
				return " Products"
			elsif controller.action_name == 'vendors'
				return " Vendors"
			else
				return ""
			end
		else
			return ""
		end
	end

	def get_location_name
		return ' Location Name: ' + @location.locName
	end

end
