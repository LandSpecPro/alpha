module ProductHelper

	def filter_by_categories(featureditems)

		if not params[:categories].nil?

			@result = []
			featureditems.each do |fi|
				params[:categories].each do |c|
					if ProductHasCategory.where(:featured_item_id => fi.id, :category_id => c, :active => true).count > 0
						@result << fi
						break
					end
				end
			end

			return @result
		else
			return featureditems
		end

	end

	def search_for_all
		@featuredItems = FeaturedItem.where(:active => true)
		return filter_by_categories(@featuredItems)
	end

	def search_for_featured_items_with_distance_only(distance)
		@featuredItems = FeaturedItem.near(current_user.currentCity + ', ' + current_user.currentState + ', ', distance).where(:active => true)
		return filter_by_categories(@featuredItems)
	end

	def search_for_featured_items_with_query_only(query)
		@query = Product.search_all_products(query)

		@result = []
		@query.each do |p|
			FeaturedItem.where(:product_id => p.id, :active => true).each do |fi|
				@result << fi
			end
		end

		return filter_by_categories(@result)
	end

	def search_for_featured_items_with_query_and_distance(query, distance)
	    @query = Product.search_all_products(query)
	    @featureditems = FeaturedItem.near(current_user.currentCity + ', ' + current_user.currentState + ', ', distance).where(:active => true)

	    @result = []
	    @query.each do |p|
	      @featureditems.each do |fi|
	        if p.id == fi.product_id
	          @result << fi
	        end
	      end
	    end

	    return filter_by_categories(@result)
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

	def require_id_parameter
### HERE REDIRECT ERROR MESSAGE BASED ON PROBLEM
		if params[:id].blank?
			redirect_to locations_manage_url # ERROR PAGE - DONT REDIRECT HOME
			return false
		else
			return true
		end
	end		

end
