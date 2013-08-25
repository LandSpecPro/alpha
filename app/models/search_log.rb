class SearchLog < ActiveRecord::Base
	include ModelHelper
	
	attr_accessible :searchTerm, :user_id, :location, :distanceFrom, :searchType, :categories, :numResults, :resultsView
	belongs_to :user

	
end
