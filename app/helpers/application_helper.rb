module ApplicationHelper

	def get_page_title
		if controller.controller_name == 'account'
			return "Account"
		elsif controller.controller_name == 'locations' and controller.action_name == 'edit'
			return "Edit Location"
		elsif controller.controller_name == 'locations'
			return "Locations"
		elsif controller.controller_name == 'bus_vendors' and controller.action_name == 'manage'
			return "Account Management"
		elsif controller.controller_name == 'bus_buyers' and controller.action_name == 'manage'
			return "Account Management"
		else
			return ""
		end
	end

	def get_page_subtitle
		if controller.controller_name == 'locations' and controller.action_name == 'manage'
			return "Manage your locations"
		elsif controller.controller_name == 'locations' and controller.action_name == 'new'
			return "Add a new location"
		elsif controller.controller_name == 'locations' and controller.action_name == 'destroy'
			return "Delete this location?"
		elsif controller.controller_name == 'locations' and controller.action_name == 'edit'
			return get_location_name
		else
			return ""
		end
	end

	def get_location_name
		return 'Location Name: ' + @location.locName
	end

end
