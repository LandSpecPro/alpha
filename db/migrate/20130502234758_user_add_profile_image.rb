class UserAddProfileImage < ActiveRecord::Migration
  def up

  	add_attachment :users, :profileImage

  end

  def down

  	remove_attachment :users, :profileImage

  end
end
