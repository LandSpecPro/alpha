class UserAddProfileImage < ActiveRecord::Migration
  def up

  	remove_attachment :bus_buyers, :profileImage
  	add_attachment :bus_buyers, :logo

  	add_attachment :users, :profileImage

  end

  def down

  	add_attachment :bus_buyers, :profileImage
  	remove_attachment :bus_buyers, :logo

  	remove_attachment :users, :profileImage

  end
end
