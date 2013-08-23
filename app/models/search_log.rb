class SearchLog < ActiveRecord::Base
	include ModelHelper
	
	attr_accessible :searchTerm, :user_id, :location, :distanceFrom, :searchType, :categories, :numResults
	belongs_to :user

	
end
