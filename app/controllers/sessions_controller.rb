class SessionsController < ApplicationController
  
  def new
  	#code
  end

  def create
  	@user = User.authenticate(params[:email], params[:password])
		if @user		
			flash[:notice] = "You've been logged in."		
			session[:user_id] = @user.id
			render "products/index"
		else		
			flash[:alert] = "There was a problem logging you in."
			redirect_to login_path
		end
  end

    def destroy    
    	#session[:user_id] = nil
    	session.clear
    	flash[:notice] = "You've been logged out successfully."
    	redirect_to "/"    	    	
    end
end
