class ChangeProductColumnTypes < ActiveRecord::Migration
  def up
  	change_column :products, :commonName, :string
  	change_column :products, :latinName, :string
  	change_column :products, :altName, :string
  end

  def down
  	change_column :products, :commonName, :text
  	change_column :products, :latinName, :text
  	change_column :products, :altName, :text
  end
end
