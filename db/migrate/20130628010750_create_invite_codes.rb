class CreateInviteCodes < ActiveRecord::Migration
  def change
    create_table :invite_codes do |t|

    	t.string :code, :null => :false, :unique => true
    	t.boolean :used, :null => :false, :default => false
    	t.integer :invite_id
    	t.integer :user_id

      	t.timestamps
    end
  end
end
