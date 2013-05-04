class CreateBusBuyers < ActiveRecord::Migration
  	def change
		create_table :bus_buyers do |t|
			t.string :busName, :null => false
			t.timestamps
		end

		add_attachment :bus_buyers, :profileImage

  	end
end
