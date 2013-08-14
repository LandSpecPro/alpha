class DefaultPublicUrlToActive < ActiveRecord::Migration
  def up
  	change_column :locations, :public_url_active, :boolean, :default => true, :null => false
  end

  def down
  	change_column :locations, :public_url_active, :boolean, :default => false, :null => false
  end
end