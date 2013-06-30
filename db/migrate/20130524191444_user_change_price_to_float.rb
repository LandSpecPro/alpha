class UserChangePriceToFloat < ActiveRecord::Migration
  def up
  	change_column :featured_items, :price, :float
  end

  def down
  	change_column :featured_items, :price, :integer
  end
end
