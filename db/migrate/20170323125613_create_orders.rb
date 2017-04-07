class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :order_number
      t.datetime :order_datetime
      t.integer :user_id
      t.float :total
      t.boolean :is_confirmed , default: true

      t.timestamps null: false
    end
  end
end
