class FavProduct < ActiveRecord::Base
	attr_accessible :user_id, :product_id
	belongs_to :user
	belongs_to :product
end
