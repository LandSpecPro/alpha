class CreateBusVendors < ActiveRecord::Migration
  def change
    create_table :bus_vendors do |t|

      t.timestamps
    end
  end
end
