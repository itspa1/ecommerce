class ApiController < ApplicationController


	def check_email
		@user = User.find_by_email(params[:email_id]);
	end
end
