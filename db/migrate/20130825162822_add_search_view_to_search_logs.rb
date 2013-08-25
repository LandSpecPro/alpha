class AddSearchViewToSearchLogs < ActiveRecord::Migration
  def up
  	add_column :search_logs, :resultsView, :string
  end

  def down
  	remove_column :search_logs, :resultsView
  end
end
