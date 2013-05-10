module ApplicationHelper

	def get_page_title
		if controller.controller_name == 'account'
			return "Account"
		elsif controller.controller_name == 'locations'
			return "Locations"
		elsif controller.controller_name == 'bus_vendors' and controller.action_name == 'manage'
			return "Vendor Dashboard"
		elsif controller.controller_name == 'bus_buyers' and controller.action_name == 'manage'
			return "Buyer Dashboard"
		else
			return ""
		end
	end

	def get_page_subtitle
		if controller.controller_name == 'locations' and controller.action_name == 'manage'
			return "Manage your locations"
		elsif controller.controller_name == 'locations' and controller.action_name == 'new'
			return "Add a new location"
		else
			return ""
		end
	end

end
