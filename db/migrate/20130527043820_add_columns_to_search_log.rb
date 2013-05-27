class AddColumnsToSearchLog < ActiveRecord::Migration
  def up
  	add_column :search_logs, :currentState, :string
  	add_column :search_logs, :currentCity, :string
  	add_column :search_logs, :categories, :text
  	add_column :search_logs, :distanceFrom, :string
  	add_column :search_logs, :searchType, :text
  end

  def down
  	remove_column :search_logs, :currentState
  	remove_column :search_logs, :currentCity
  	remove_column :search_logs, :categories
  	remove_column :search_logs, :distanceFrom
  	remove_column :search_logs, :searchType
  end
end
