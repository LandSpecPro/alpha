class CreateSearchLogs < ActiveRecord::Migration

  def up

  	create_table :search_logs do |t|
    	t.string :searchTerm
    	t.integer :user_id
		t.timestamps
    end

  end

  def down

  	drop_table :search_logs

  end

end
