class UserDetail < ActiveRecord::Base

	attr_accessible :first_name, :last_name, :company_name, :phone_number, :user_type, :user_category, :city, :state, :zip

	has_many :locations
	accepts_nested_attributes_for :locations

	belongs_to :user

	validates_presence_of :phone_number, :message => "A valid phone number is requried."

end
