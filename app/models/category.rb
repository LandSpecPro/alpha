class Category < ActiveRecord::Base
	include ModelHelper

  	attr_accessible :category, :parentCategory
end
