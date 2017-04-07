class ReviewsController < ApplicationController

	before_action :authenticate_user!, for: [:create, :destroy]

	def create

		@review = Review.new(review_params)
		@review.user_id = current_user.id
		if user_signed_in?
			if @review.save
				redirect_to product_path(@review.product_id) , notice: "Review Added"
			else 
				render :back
			end
		end
	end

	def destroy

		@review = Review.find(params[:id])
		if @review.destroy
			redirect_to :back ,notice: "Review Deleted"
		else
			render :back
		end
	end

	private

	def review_params
		params[:review].permit(:body, :rating ,:product_id)
	end
	
end
