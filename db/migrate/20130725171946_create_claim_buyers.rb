class CreateClaimBuyers < ActiveRecord::Migration
  def change
    create_table :claim_buyers do |t|
    	t.string :user_login
    	t.string :user_email
    	t.string :user_type
    	t.string :bus_name
    	t.string :bus_phone
    	t.string :claim_token
    	t.boolean :claimed, :default => false
    end
  end
end