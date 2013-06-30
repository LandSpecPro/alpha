class CreateNewsletterEmails < ActiveRecord::Migration
  def change
    create_table :newsletter_emails do |t|

    	t.string :email, :null => :false
      	t.timestamps
    end
  end
end
