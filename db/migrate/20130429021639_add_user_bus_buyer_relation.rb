class AddUserBusBuyerRelation < ActiveRecord::Migration
    def up
  		add_column :users, :bus_buyer_id, :integer
  		add_column :bus_buyers, :user_id, :integer
	end

	def down
		remove_column :users, :bus_buyer_id
	  	remove_column :bus_buyers, :user_id
	end
end
