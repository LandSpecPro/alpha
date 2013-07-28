class Category < ActiveRecord::Base
  attr_accessible :id, :parent_id, :hierarchy_level, :cat_name, :locations_attributes

  has_many :category_to_locations
  has_many :locations, :through => :category_to_locations
  accepts_nested_attributes_for :locations
  
  # Will always return nil if there is no parent
  def parent
  	if self.parent_id == -1
  		return nil
  	else
  		return Category.find(self.parent_id)
  	end
  end

  def parent_name
  	if self.parent_id == -1
  		return nil
  	else
  		return Category.find(self.parent_id).cat_name
  	end
  end

  def parent_hierarchy_level
  	if self.parent_id == -1
  		return nil
  	else
  		return Category.find(self.parent_id).hierarchy_level
  	end
  end

  def has_children
  	if Category.where(:parent_id => self.id).count > 0
  		return true
  	else
  		return false
  	end
  end

  def direct_children
  	return Category.where(:parent_id => self.id)
  end

  def siblings
  	return Category.where(:parent_id => self.parent_id)
  end

  def self.all_hierarchy_one
  	return Category.where(:hierarchy_level => 1)
  end

  def self.all_hierarchy_two
  	return Category.where(:hierarchy_level => 2)
  end

  def self.all_hierarchy_three
  	return Category.where(:hierarchy_level => 3)
  end

  def get_locations
    return self.locations.count
  end
end
