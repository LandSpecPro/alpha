class AddTaglineToUserDetails < ActiveRecord::Migration
  
  def up
  	add_column :user_details, :tagline, :text
  end

  def down
  	remove_column :user_details, :tagline
  end

end
