class Inventory < ActiveRecord::Base
  attr_accessible :location_id, :num_views, :file_file_name

  belongs_to :location

  has_attached_file :file,
		:path => 'vendors/:id/inventory/inventory_:basename.:extension'

end
