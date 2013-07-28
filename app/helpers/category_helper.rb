module CategoryHelper

	def add_category_to_location(category, location)

		location.categories << category
		location.save

	end

end