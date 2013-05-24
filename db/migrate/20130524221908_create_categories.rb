class CreateCategories < ActiveRecord::Migration
  def change
    
  	create_table :categories do |t|
    	t.string :category
    	t.string :parentCategory
    end

  end
end