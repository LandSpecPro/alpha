class Inventory < ActiveRecord::Base
  attr_accessible :location_id, :num_views, :file_file_name, :file

  belongs_to :location

  has_attached_file :file,
		:path => 'vendors/:id/inventory/inventory_:basename.:extension'

  validates_presence_of :file, :message => "No inventory file selected!"

end
