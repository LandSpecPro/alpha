class CreateBusVendors < ActiveRecord::Migration
  def change
    create_table :bus_vendors do |t|
    	t.string :busName, :null => false
    	t.timestamps
    end

    add_attachment :bus_vendors, :logo
    
  end
end
