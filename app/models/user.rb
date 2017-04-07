class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :carts
  has_many :reviews
  has_many :orders
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def self.report 
  	users_array = []
  	users = User.all.where('is_admin = ?', false)
  	users.each do |user|
      user_orders = user.orders
      users_hash = {}
  		users_hash["email"] = user.email
  		users_hash["order_count"] = user.orders.size
      if !user_orders.empty?
  		users_hash["last_order_date"] = user_orders.last.order_datetime
      end
  		users_hash["total_order"] = user.orders.sum(:total) # user.orders.pluck(:total).inject(:+)
  		users_array.push(users_hash)
  		end
      return users_array
	end 
	
  def self.orderreport
    orders_array= []
    orders = Order.all
        range = []
    orders.each do |order|
        line_items = order.order_line_items
        line_items.each do|line_item|
          range.push(line_item.price)
          end
    end
    mid = (range.first + range.last)/2
    half_mid = mid/2

    orders.each do |order|
      order_hash = {}
      line_items = order.order_line_items
      order_hash["number"] = order.order_number
      order_hash["customer"] = order.user.email
      order_hash["total"] = order.total
      line_items.each do|line_item|
        line_item_hash = {}
        if line_item.price >= 0 && line_item.price <= half_mid
          line_item_hash["very low"] = line_item.product.name
          order_hash["order_details"] = line_item_hash
          orders_array.push(order_hash)
        elsif line_item.price >= half_mid && line_item.price <= mid
          line_item_hash["low"] = line_item.product.name
          order_hash["order_details"] = line_item_hash
          orders_array.push(order_hash)
        elsif line_item.price >= mid && line_item.price <= mid + half_mid
          line_item_hash["little high"] = line_item.product.name
          order_hash["order_details"] = line_item_hash
          orders_array.push(order_hash)
        elsif line_item.price >= mid + half_mid && line_item.price <= range.last 
          line_item_hash["high"] = line_item.product.name
          order_hash["order_details"] = line_item_hash
          orders_array.push(order_hash)
        end
      end
     end
     return orders_array
  end

end
