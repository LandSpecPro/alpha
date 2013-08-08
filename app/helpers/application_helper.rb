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

	def get_state_abbr(state)

		if state == 'Alabama' or state == 'alabama'
			return 'AL'
		elsif state == 'Alaska' or state == 'alaska'
			return 'AK'
		elsif state == 'Arizona' or state == 'arizona'
			return 'AZ'
		elsif state == 'Arkansas' or state == 'arkansas'
			return 'AR'
		elsif state == 'California' or state == 'california'
			return 'CA'
		elsif state == 'Colorado' or state == 'colorado'
			return 'CO'
		elsif state == 'Connecticut' or state == 'connecticut'
			return 'CT'
		elsif state == 'Delaware' or state == 'delaware'
			return 'DE'
		elsif state == 'Florida' or state == 'florida'
			return 'FL'
		elsif state == 'Georgia' or state == 'georgia'
			return 'GA'
		elsif state == 'Hawaii' or state == 'hawaii'
			return 'HI'
		elsif state == 'Idaho' or state == 'idaho'
			return 'ID'
		elsif state == 'Illinois' or state == 'illinois'
			return 'IL'
		elsif state == 'Indiana' or state == 'indiana'
			return 'IN'
		elsif state == 'Iowa' or state == 'iowa'
			return 'IA'
		elsif state == 'Kansas' or state == 'kansas'
			return 'KS'
		elsif state == 'Kentucky' or state == 'kentucky'
			return 'KY'
		elsif state == 'Louisiana' or state == 'louisiana'
			return 'LA'
		elsif state == 'Maine' or state == 'maine'
			return 'ME'
		elsif state == 'Maryland' or state == 'maryland'
			return 'MD'
		elsif state == 'Massachusetts' or state == 'massachusetts'
			return 'MA'
		elsif state == 'Michigan' or state == 'michigan'
			return 'MI'
		elsif state == 'Minnesota' or state == 'minnesota'
			return 'MN'
		elsif state == 'Mississippi' or state == 'mississippi'
			return 'MS'
		elsif state == 'Missouri' or state == 'missouri'
			return 'MO'
		elsif state == 'Montana' or state == 'montana'
			return 'MT'
		elsif state == 'Nebraska' or state == 'nebraska'
			return 'NE'
		elsif state == 'Nevada' or state == 'nevada'
			return 'NV'
		elsif state == 'New Hampshire' or state == 'new hampshire'
			return 'NH'
		elsif state == 'New Jersey' or state == 'new jersey'
			return 'NJ'
		elsif state == 'New Mexico' or state == 'new mexico'
			return 'NM'
		elsif state == 'New York' or state == 'new york'
			return 'NY'
		elsif state == 'North Carolina' or state == 'north carolina'
			return 'NC'
		elsif state == 'North Dakota' or state == 'north dakota'
			return 'ND'
		elsif state == 'Ohio' or state == 'ohio'
			return 'OH'
		elsif state == 'Oklahoma' or state == 'oklahoma'
			return 'OK'
		elsif state == 'Oregon' or state == 'oregon'
			return 'OR'
		elsif state == 'Pennsylvania' or state == 'pennsylvania'
			return 'PA'
		elsif state == 'Rhode Island' or state == 'rhode island'
			return 'RI'
		elsif state == 'South Carolina' or state == 'south carolina'
			return 'SC'
		elsif state == 'South Dakota' or state == 'south dakota'
			return 'SD'
		elsif state == 'Tennessee' or state == 'tennessee'
			return 'TN'
		elsif state == 'Texas' or state == 'texas'
			return 'TX'
		elsif state == 'Utah' or state == 'utah'
			return 'UT'
		elsif state == 'Vermont' or state == 'vermont'
			return 'VT'
		elsif state == 'Virginia' or state == 'virginia'
			return 'VA'
		elsif state == 'Washington' or state == 'washington'
			return 'WA'
		elsif state == 'West Virginia' or state == 'west virginia'
			return 'WV'
		elsif state == 'Wisconsin' or state == 'wisconsin'
			return 'WI'
		elsif state == 'Wyoming' or state == 'wyoming'
			return 'WY'
		else
			return nil
		end
	end

	def get_state_from_abbr(abbr)
		if abbr =='AL'
			return 'Alabama'
		elsif abbr == 'AK'
			return 'Alaska'
		elsif abbr == 'AZ'
			return 'Arizona'
		elsif abbr == 'AR'
			return 'Arkansas'
		elsif abbr == 'CA'
			return 'California'
		elsif abbr == 'CO'
			return 'Colorado'
		elsif abbr == 'CT'
			return 'Connecticut'
		elsif abbr == 'DE'
			return 'Delaware'
		elsif abbr == 'FL'
			return 'Florida'
		elsif abbr == 'GA'
			return 'Georgia'
		elsif abbr == 'HI'
			return 'Hawaii'
		elsif abbr == 'ID'
			return 'Idaho'
		elsif abbr == 'IL'
			return 'Illinois'
		elsif abbr == 'IN'
			return 'Indiana'
		elsif abbr == 'IA'
			return 'Iowa'
		elsif abbr == 'KS'
			return 'Kansas'
		elsif abbr == 'KY'
			return 'Kentucky'
		elsif abbr == 'LA'
			return 'Louisiana'
		elsif abbr == 'ME'
			return 'Maine'
		elsif abbr == 'MD'
			return 'Maryland'
		elsif abbr == 'MA'
			return 'Massachusetts'
		elsif abbr == 'MI'
			return 'Michigan'
		elsif abbr == 'MN'
			return 'Minnesota'
		elsif abbr == 'MS'
			return 'Mississippi'
		elsif abbr == 'MO'
			return 'Missouri'
		elsif abbr == 'MT'
			return 'Montana'
		elsif abbr == 'NE'
			return 'Nebraska'
		elsif abbr == 'NV'
			return 'Nevada'
		elsif abbr == 'NH'
			return 'New Hampshire'
		elsif abbr == 'NJ'
			return 'New Jersey'
		elsif abbr == 'NM'
			return 'New Mexico'
		elsif abbr == 'NY'
			return 'New York'
		elsif abbr == 'NC'
			return 'North Carolina'
		elsif abbr == 'ND'
			return 'North Dakota'
		elsif abbr == 'OH'
			return 'Ohio'
		elsif abbr == 'OK'
			return 'Oklahoma'
		elsif abbr == 'OR'
			return 'Oregon'
		elsif abbr == 'PA'
			return 'Pennsylvania'
		elsif abbr == 'RI'
			return 'Rhode Island'
		elsif abbr == 'SC'
			return 'South Carolina'
		elsif abbr == 'SD'
			return 'South Dakota'
		elsif abbr == 'TN'
			return 'Tennessee'
		elsif abbr == 'TX'
			return 'Texas'
		elsif abbr == 'UT'
			return 'Utah'
		elsif abbr == 'VT'
			return 'Vermont'
		elsif abbr == 'VA'
			return 'Virginia'
		elsif abbr == 'WA'
			return 'Washington'
		elsif abbr == 'WV'
			return 'West Virginia'
		elsif abbr == 'WI'
			return 'Wisconsin'
		elsif abbr == 'WY'
			return 'Wyoming'
		else
			return nil
		end
	end

	def get_page_title

		@action = controller.action_name
		@controller = controller.controller_name

		if @action == 'search'
			return "Search"
		elsif @controller == 'locations' and @action == 'edit'
			return "Edit Location"
		elsif @controller == 'locations' and @action == 'delete_featureditem'
			return "Delete Featured Item Confirmation"
		elsif @controller == 'locations'
			return "Locations"
		elsif @controller == 'bus_vendors' and @action == 'manage'
			return "Account Management"
		elsif @controller == 'bus_vendors' and (@action == 'manage_company' or @action == 'update')
			return "Company Management"
		elsif @controller == 'bus_buyers' and @action == 'manage'
			return "Account Management"
		elsif @controller == 'bus_buyers' and (@action == 'manage_company' or @action == 'update')
			return "Company Management"
		elsif @controller == 'products'
			return "Products"
		elsif @controller == 'users' and @action == 'password_reset'
			return "Password Reset"
		elsif @controller == 'users' and @action == 'update'
			return "Account Management"
		elsif @controller == 'favorites'
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
				return " for Suppliers"
			else
				return ""
			end
		elsif controller.controller_name == 'products'
			if controller.action_name == 'browseall'
				return " Browse All"
			elsif controller.action_name == 'search'
				return " for Products"
			elsif controller.action_name == 'view'
				return " View Featured Item"
			elsif controller.action_name == 'edit'
				return " Edit " + @product.commonName
			else
				return ""
			end
		elsif controller.controller_name == 'favorites'
			if controller.action_name == 'products'
				return " Products"
			elsif controller.action_name == 'vendors'
				return " Suppliers"
			else
				return ""
			end
		else
			return ""
		end
	end

	def get_location_name
		unless @location.locName.blank?
			return ' Location Name: ' + @location.locName
		else
			return ' Location: ' + @location.busName
		end
	end

	def title(page_title)
		content_for(:title) { page_title }
	end

end
