class User < ActiveRecord::Base
  acts_as_authentic do |c|
  	# Configuration options go here
  end
end
