class SearchLog < ActiveRecord::Base
	attr_accessible :searchTerm, :id
	belongs_to :user
end
