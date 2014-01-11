class CreateUserDetails < ActiveRecord::Migration
  def change
    create_table :user_details do |t|

    	t.string :first_name
    	t.string :last_name

    	t.string :user_type

    	t.string :buyer_type
    	t.string :vendor_type
   
    	t.string :city
    	t.string :state
    	t.string :zip

    	t.integer :year_started_landscaping
    	t.integer :approx_jobs_completed
    	t.decimal :approx_job_price_min
    	t.decimal :approx_job_price_max
    	t.decimal :approx_material_cost_min
    	t.decimal :approx_material_cost_max

     	t.timestamps
    end
  end
end
