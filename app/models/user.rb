class User < ActiveRecord::Base
	attr_accessible :login, :email, :password, :password_confirmation, :userType

  	acts_as_authentic do |c|
  		# Configuration options go here
  	end
  	
end
