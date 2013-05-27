class SearchLog < ActiveRecord::Base
	attr_accessible :searchTerm, :user_id, :currentState, :currentCity, :categories, :distanceFrom, :searchType
	belongs_to :user
end
