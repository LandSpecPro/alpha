class CreateSearchLogs < ActiveRecord::Migration

  def up

  	create_table :search_logs do |t|
    	t.string :searchTerm
    	t.integer :user_id
		t.timestamps
    end

  	add_column :users, :search_log_id, :integer

  end

  def down

  	remove_column :users, :search_log_id, :integer

  	drop_table :search_logs

  end

end
