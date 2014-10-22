class CartsController < ApplicationController
  skip_before_action :authorize, only: [:create, :destroy, :update]
  before_action :set_cart, only: [:show, :edit, :update, :destroy]

  #xu ly loi khi truy cap vao gio hang
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart
    #redirect_to :controller => 'store', :action => 'index'
  #end

  
  def index
    @carts = Cart.all
    #rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart
  end


  def show
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  
  def edit
  end

  
  def create
    @cart = Cart.new(cart_params)
    
    
      if @cart.save
        render :show, notice: 'Cart created '
      else
        render :new
      end
    
  end

  
  def update    
      if @cart.update(cart_params)
        render :show, status: :ok
      else
        render :edit
     
      end    
  end


  def destroy
    @cart.destroy if @cart.id = session[:cart_id]

    #cancel session
    session[:cart_id] = nil
    redirect_to store_url    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      params[:cart]
    end

    def invalid_cart
      logger_error "Invalid cart #{params[:id]}"
      redirect_to store_url, notice: 'Invalid cart'
    end
end
