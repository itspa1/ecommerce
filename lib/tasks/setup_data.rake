task :setup_data => :environment do 

10.times do
	category = Category.new
	category.name = Faker::Commerce.department(1)
	category.save
end

end

=begin
1000.times do 
	product = Product.new
	product.name = Faker::Commerce.product_name
	product.description = Faker::Lorem.paragraph
	product.price = Faker::Commerce.price(10..10000)
	product.availability = [true,false].sample
	if product.availability
	product.stock = Random.rand(1..100)
	else
		product.stock = 0
	end
	product.category_id = Category.all.pluck(:id).sample
	product.save
end
=end

=begin
50.times do 
		user = User.new
		user.email = Faker::Internet.email
		user.password = "secret123"
		user.save
	end

	users = User.where('is_admin = ?',false) 
	users.each do |user|
		(2..15).to_a.sample.times do 
		cart = Cart.new
		cart.user_id = user.id
		(1..5).to_a.sample.times do
		cart.product_id = Product.all.pluck(:id).sample
		cart.quantity = Random.rand(1..5)
		end
		cart.save
		order = Order.new
		order.user_id = user.id
		order.order_number = "DCT-#{Random.rand(1..1000)}"
		order.order_datetime = Faker::Date.backward(365)
		order.save
		end
	end
end
=end