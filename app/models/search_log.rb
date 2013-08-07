class SearchLog < ActiveRecord::Base
	include ModelHelper
	
	attr_accessible :searchTerm, :user_id, :currentState, :currentCity, :distanceFrom, :searchType
	belongs_to :user

	
end
