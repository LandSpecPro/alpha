class ChangePhoneTypesToString < ActiveRecord::Migration
  def up

  	change_column :locations, :primaryPhone, :string
  	change_column :locations, :secondaryPhone, :string
  	change_column :locations, :fax, :string
  	change_column :locations, :zip, :string
  end

  def down

  	change_column :locations, :primaryPhone, :integer
  	change_column :locations, :secondaryPhone, :integer
  	change_column :locations, :fax, :integer
  	change_column :locations, :zip, :integer
  end
end
