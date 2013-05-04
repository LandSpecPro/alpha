class ChangePhoneTypesToString < ActiveRecord::Migration
  def up
  	change_column :bus_buyers, :busPhone, :string
  	change_column :bus_buyers, :busFax, :string
  	change_column :bus_buyers, :zip, :string

  	change_column :bus_vendors, :busPhone, :string
  	change_column :bus_vendors, :busFax, :string

  	change_column :contacts, :primaryPhone, :string
  	change_column :contacts, :secondaryPhone, :string
  	change_column :contacts, :fax, :string

  	change_column :locations, :primaryPhone, :string
  	change_column :locations, :secondaryPhone, :string
  	change_column :locations, :fax, :string
  	change_column :locations, :zip, :string
  end

  def down
  	change_column :bus_buyers, :busPhone, :integer
  	change_column :bus_buyers, :busFax, :integer
  	change_column :bus_buyers, :zip, :integer

  	change_column :bus_vendors, :busPhone, :integer
  	change_column :bus_vendors, :busFax, :integer

  	change_column :contacts, :primaryPhone, :integer
  	change_column :contacts, :secondaryPhone, :integer
  	change_column :contacts, :fax, :integer

  	change_column :locations, :primaryPhone, :integer
  	change_column :locations, :secondaryPhone, :integer
  	change_column :locations, :fax, :integer
  	change_column :locations, :zip, :integer
  end
end
