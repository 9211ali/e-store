class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.string :customer_email
      t.integer :status, default: 0
      t.text :address
      t.integer :total_amount

      t.timestamps
    end
  end
end
