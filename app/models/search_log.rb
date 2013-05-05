class SearchLog < ActiveRecord::Base
	attr_accessible :searchTerm, :user_id
	belongs_to :user
end
