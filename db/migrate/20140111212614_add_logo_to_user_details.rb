class AddLogoToUserDetails < ActiveRecord::Migration
  def change
  	add_attachment :user_details, :logo
  end
end
