class DashboardController < ApplicationController
	before_action :check_user_authority, only: %w[index]
	layout 'dashboard/dashboard'
	
	def index
	end
	
	private
	def check_user_authority
		@user = current_user
		if @user.authority.nil?
			flash[:alert] = "権限がありません"
			redirect_to root_path
		else
			if @user.authority.eql?("1")
				flash[:alert] = "権限がありません"
				redirect_to root_path 
			end
		end
	end
end
