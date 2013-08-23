class UpdateSearchLogColumns < ActiveRecord::Migration
  
  def up
  	remove_column :search_logs, :currentState
  	remove_column :search_logs, :currentCity
  	add_column :search_logs, :location, :string
    add_column :search_logs, :numResults, :integer
  end

  def down
  	add_column :search_logs, :currentState, :string
  	add_column :search_logs, :currentCity, :string
  	remove_column :search_logs, :location
    remove_column :search_logs, :numResults
  end

end