class Product < ActiveRecord::Base

	has_many :order_line_items
	belongs_to :category
	has_many :carts
	has_many :reviews
	
	validates_presence_of :name , :price, :availability , :stock, :category_id
	validates_numericality_of :price, greater_than: 1
	validates_numericality_of :stock, greater_than_or_equal_to: 0 

	mount_uploader :cover, CoverUploader
end
