class SearchLog < ActiveRecord::Base
	include ModelHelper
	
	attr_accessible :searchTerm, :user_id, :currentState, :currentCity, :categories, :distanceFrom, :searchType
	belongs_to :user
end
