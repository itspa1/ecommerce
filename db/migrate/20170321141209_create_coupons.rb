class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :name
      t.integer :amount

      t.timestamps null: false
    end
  end
end
