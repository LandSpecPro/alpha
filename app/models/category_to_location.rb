class CategoryToLocation < ActiveRecord::Base
  attr_accessible :category_id, :location_id

  belongs_to :category
  belongs_to :location
  
end
