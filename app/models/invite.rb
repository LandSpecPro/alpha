class Invite < ActiveRecord::Base
  attr_accessible :inviteSent, :email, :userType, :busName, :busType, :state

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :on => :create, :message => "Email address is not valid."
  validates_presence_of :userType, :message => "You must select Supplier or Buyer."
  validates_presence_of :busName, :message => "You must enter your Business Name."

end
