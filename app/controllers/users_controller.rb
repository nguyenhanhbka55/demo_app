class UsersController < ApplicationController
	def index
		@users= User.all
	end
  def new
  	@user = User.new
  end
  def show
  	@user = User.find(params[:id])  
  end
  	def create
		@user = User.new(user_params)
		if @user.save
			flash[:notice] = "Welcome to the site!"
			redirect_to "/"
			#render :action => 'show'
		else
			flash[:alert] = "There was a problem creating your account. Please try again."
			redirect_to :back
		end
	end

	def update
		
	end

	private
		def user_params
			params.require(:user).permit(:email, :password, :password_confirmation)
		end
end
