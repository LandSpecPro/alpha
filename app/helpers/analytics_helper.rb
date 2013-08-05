module AnalyticsHelper

	def eight_digit_random_number

		values = [('a'..'z'),('A'..'Z'),(0..9)].map{|i| i.to_a}.flatten
		return (0...8).map{ values[rand(values.length)] }.join

	end


	def add_location_viewed(user_id, location_id)

		@locviewed = LocationViewLog.new
		@locviewed.viewed_by_user_id = user_id
		@locviewed.location_id = location_id
		@locviewed.save

	end

	def add_featured_item_viewed(user_id, featured_item_id)

		@fiviewed = FeaturedItemViewLog.new
		@fiviewed.viewed_by_user_id = user_id
		@fiviewed.featured_item_id = featured_item_id
		@fiviewed.save

	end

end