class CreatePaymentNotifications < ActiveRecord::Migration
  def change
    create_table :payment_notifications do |t|
      t.text :params
      t.string :status
      t.string :transaction_id
      t.string :location_id
      t.string :user_id

      t.timestamps
    end
  end
end
