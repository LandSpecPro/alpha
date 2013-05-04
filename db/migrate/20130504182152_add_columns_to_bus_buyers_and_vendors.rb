class AddColumnsToBusBuyersAndVendors < ActiveRecord::Migration
  
  def up
  	add_column :bus_buyers, :busType, :string
  	add_column :bus_buyers, :busPhone, :integer
  	add_column :bus_buyers, :busFax, :integer
  	add_column :bus_buyers, :busContact, :string
  	add_column :bus_buyers, :busEmail, :string
  	add_column :bus_buyers, :busWebsite, :string
  	add_column :bus_buyers, :address1, :string
  	add_column :bus_buyers, :address2, :string
  	add_column :bus_buyers, :city, :string
  	add_column :bus_buyers, :state, :string
  	add_column :bus_buyers, :zip, :integer

  	add_column :bus_vendors, :busType, :string
  	add_column :bus_vendors, :busPhone, :integer
  	add_column :bus_vendors, :busFax, :integer
  	add_column :bus_vendors, :busContact, :string
  	add_column :bus_vendors, :busEmail, :string
  	add_column :bus_vendors, :busWebsite, :string
  end

  def down
	remove_column :bus_buyers, :busType
  	remove_column :bus_buyers, :busPhone
  	remove_column :bus_buyers, :busFax
  	remove_column :bus_buyers, :busContact
  	remove_column :bus_buyers, :busEmail
  	remove_column :bus_buyers, :busWebsite
  	remove_column :bus_buyers, :address1
  	remove_column :bus_buyers, :address2
  	remove_column :bus_buyers, :city
  	remove_column :bus_buyers, :state
  	remove_column :bus_buyers, :zip

  	remove_column :bus_vendors, :busType
  	remove_column :bus_vendors, :busPhone
  	remove_column :bus_vendors, :busFax
  	remove_column :bus_vendors, :busContact
  	remove_column :bus_vendors, :busEmail
  	remove_column :bus_vendors, :busWebsite
  end

end
