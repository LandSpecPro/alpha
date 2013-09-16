class PaymentNotification < ActiveRecord::Base
  attr_accessible :location_id, :params, :status, :transaction_id, :user_id

  belongs_to :location
  serialize :params
  after_create :update_location

  private
  def update_location
  	if status == "Completed"
  		location.update_attributes(:is_subscribed_to_inventory => true)
  	end
  end
  
end
