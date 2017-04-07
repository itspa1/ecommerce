class CartsController < ApplicationController


	def index
		@line_items = current_user.carts
		if @line_items.empty?
			session[:coupon_code] = nil
		end
	end

	def create
		@cart = Cart.new(cart_params)
		@cart.add_or_update #method defined to determine whether to create a new record or update
			redirect_to carts_path, notice: "Successfully Added To Cart"
	end

	def destroy
		@cart = Cart.find(params[:id])
		if @cart.destroy
			redirect_to carts_path, notice: "Successfully Removed from Cart"
		end
	end

	def update
		@cart = Cart.find(params[:id])
		if @cart.update_attributes(cart_params)
			redirect_to :back , notice: "Successfully Updated Cart"
		end
	end

	private

	def cart_params
		params[:cart].permit(:product_id, :quantity, :cart_id, :user_id)
	end
	
end	
