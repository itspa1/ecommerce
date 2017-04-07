class DashboardController < ApplicationController

	before_action :check_is_admin

  def index
  	@categories = Category.all
  	@orders = Order.order('total DESC').limit(10)
  	@orderperuser = Order.all
  end
  
  def customer

  end

  def order

  end
  
end
