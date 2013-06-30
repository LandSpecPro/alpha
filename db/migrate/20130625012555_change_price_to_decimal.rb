class ChangePriceToDecimal < ActiveRecord::Migration
  def up
  	change_column :featured_items, :price, :decimal, :precision => 10, :scale => 2
  end

  def down
  	change_column :featured_items, :price, :float
  end
end
