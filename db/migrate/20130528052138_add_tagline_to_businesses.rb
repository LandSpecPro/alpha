class AddTaglineToBusinesses < ActiveRecord::Migration
  def up
  	add_column :bus_vendors, :tagline, :text
  	add_column :bus_buyers, :tagline, :text
  end

  def down
  	remove_column :bus_vendors, :tagline
  	remove_column :bus_vendors, :tagline
  end
end
