module ProductHelper

	def search_for_featured_items_with_distance_only(distance)
		@featuredItems = FeaturedItem.near(current_user.currentCity + ', ' + current_user.currentState + ', ', distance)
		return @featuredItems
	end

	def search_for_featured_items_with_query_only(query)
		@query = Product.search_all_products(query)

		@result = []
		@query.each do |p|
			FeaturedItem.where(:product_id => p.id).each do |fi|
				@result << fi
			end
		end

		return @result
	end

	def search_for_featured_items_with_query_and_distance(query, distance)
	    @query = Product.search_all_products(query)
	    @featureditems = FeaturedItem.near(current_user.currentCity + ', ' + current_user.currentState + ', ', distance)

	    @result = []
	    @query.each do |p|
	      @featureditems.each do |fi|
	        if p.id == fi.product_id
	          @result << fi
	        end
	      end
	    end

	    return @result
	end

	def update_search_log
	    @cats = ''

	    if not params[:categories].nil?
	      params[:categories].each do |c|
	        @cats = @cats + Category.find(c).category + " "
	      end
	    end

	    @searchlog = SearchLog.new(:searchTerm => params[:search], :user_id => current_user.id, :currentState => current_user.currentState, :currentCity => current_user.currentCity, :distanceFrom => params[:distance_from], :searchType => 'product', :categories => @cats)
	    @searchlog.save
	end

end
