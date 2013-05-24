class AddCurrentCityToUsers < ActiveRecord::Migration
  def up
  	add_column :users, :currentCity, :string
  	add_column :users, :currentState, :string
  end

  def down
  	remove_column :users, :currentCity
  	remove_column :users, :currentState
  end
end
