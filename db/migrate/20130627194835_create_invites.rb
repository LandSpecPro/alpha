class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|

    	t.boolean :inviteSent, :default => :false
    	t.string :email, :null => :false
    	t.string :userType
    	t.string :busName
      t.string :busType
    	t.string :state
      	t.timestamps
      	
    end
  end
end
