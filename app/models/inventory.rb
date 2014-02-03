class Inventory < ActiveRecord::Base
  attr_accessible :location_id, :num_views, :file_file_name, :file

  belongs_to :location

  has_attached_file :file,
		:path => 'vendors/:id/inventory/inventory_:basename.:extension'

  validates_presence_of :file, :message => "No inventory file selected!"

  validates_attachment_content_type :file, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'application/pdf', 'application/msword', 'application/vnd.ms-word', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'application/msexcel', 'application/vnd.ms-excel', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 'application/mspowerpoint', 'application/vnd.ms-powerpoint', 'application/vnd.openxmlformats-officedocument.presentationml.presentation', 'text/plain']

end
