class Order < ActiveRecord::Base

	has_many :order_line_items
	belongs_to :user
	before_save :update_total_for_order #callback to invoke this function beofre the order object is save
	after_save :copy_cart_line_items
	after_save :clear_user_cart
	after_save :update_stock_for_product
	#after_save :send_order_confirmation_notification


	def send_order_confirmation_notification
		Notification.order_confirmation(self).deliver!
	end

	def update_stock_for_product
		order_line_items = self.order_line_items
		order_line_items.each do|order_line_item|
			product = order_line_item.product
			quantity = order_line_item.quantity
			updated_stock = product.stock - quantity
			product.update_attributes(stock: updated_stock)
		end
	end

	def update_total_for_order
		calc_total = 0
		user = self.user
		cart_line_items = user.carts
		cart_line_items.each do |line_item|
			calc_total += line_item.quantity * line_item.product.price
		end
		self.total = calc_total
	end

	def copy_cart_line_items
		user = self.user	#fetch current user
		cart_line_items = user.carts #find all products in the cart by the user
		cart_line_items.each do |line_item|	#iterate over the collection of products in cart
			order_line_item = OrderLineItem.new	#create a new object in orderlineitem to copy content of cart
			order_line_item.order_id = self.id #assign orderId to the new object
			order_line_item.product_id = line_item.product_id	#assign the product id
			order_line_item.quantity = line_item.quantity #quantity of the product
			order_line_item.price = line_item.product.price	#as there is no reference to thte price in the cart object, we find the product via the association and then get the price of the product
			order_line_item.save
		end
	end

	def clear_user_cart
		user = self.user
		Cart.where('user_id = ?', user.id).delete_all
	end

end
