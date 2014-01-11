class CreateUserDetails < ActiveRecord::Migration
  def change
    create_table :user_details do |t|

        t.integer :user_id, :null => false, :default => 0

    	t.string :first_name
    	t.string :last_name

        t.string :company_name
        t.string :phone_number, :null => false

    	t.string :user_type
        t.string :user_category
   
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
