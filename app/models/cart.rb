class Cart < ActiveRecord::Base
	belongs_to :product
	belongs_to :user


	def add_or_update
		user = self.user #getting the data from the record and giving reference to the user object
		user_cart_line_items = user.carts #getting records belonging to the user object in the database
		if user_cart_line_items.pluck(:product_id).include? self.product_id #filtering search only for product_id and searching for a existing product with same product_id
			line_item = user_cart_line_items.find_by_product_id(self.product_id) # searching for the record in the database using the dynamic find method with product_id and setting the values in line_item object
			line_item.update_attributes(quantity: line_item.quantity + self.quantity) # updating the quantity of the existing record with the user selected quantity by adding both the quantity
		else
			self.save # if no record found this will be saved as a new record
		end
	end
end
