task :clear_data => :environment do
	#Category.delete_all
	#Product.delete_all
	Order.delete_all
	OrderLineItem.delete_all
	Cart.delete_all
	#Review.delete_all
	User.delete_all
end