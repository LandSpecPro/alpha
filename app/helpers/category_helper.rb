module CategoryHelper

	def add_category_to_location(category, location)

		unless CategoryToLocation.where(:category_id => category.id, :location_id => location.id).count > 0
			location.categories << category
			location.save
		end

		#Need to make this so it adds any number of parent categories.
		#for now, since there are only two levels, it just adds the parent if it needs to

		unless category.is_highest_level
			unless CategoryToLocation.where(:category_id => category.parent.id, :location_id => location.id).count > 0
				location.categories << category.parent
				location.save
			end
		end

	end

end