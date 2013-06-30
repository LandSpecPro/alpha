class CreateLocationHasCategories < ActiveRecord::Migration
  def change

    create_table :location_has_categories do |t|
    	t.integer :location_id
    	t.integer :category_id
    	t.timestamps
    end

  end
end
