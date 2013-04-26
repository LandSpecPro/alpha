class CreateUserSessions < ActiveRecord::Migration
  def change
    create_table :user_sessions do |t|
    	t.string :user_sessions_id, :null => false
    	t.text :data
      	t.timestamps
    end

    add_index :user_sessions, :user_sessions_id
    add_index :user_sessions, :updated_at
  
  end

  def self.down
  	drop_table :user_sessions
  end
end
