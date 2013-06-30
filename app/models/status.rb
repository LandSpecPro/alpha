class Status < ActiveRecord::Base
  attr_accessible :status, :location_id
  belongs_to :location
end
