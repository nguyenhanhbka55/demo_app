class ProductsController < ApplicationController

  skip_before_filter :authorize
  before_filter :set_cart

  include CurrentCart
  before_action :set_cart
  #before_action :set_product, only: [:show, :edit, :update, :delete]
  def home
    
  end
  def index
    #@products = Product.where('price = 0.45')
    @products = Product.find_by_sql("select * from products")
    #@products = Product.order("name").page(params[:page]).per(5)

    #@products=Product.where('id >= 1').limit(5).order('id desc').only(:order,:where)   


    #render xml: @products
    #@products = Product.all    
    #@products = Product.where("name LIKE?",'%l%')
    #@products = Product.where.not(id:[2,5])   

    #paginate dissplat all products
    #@products = Product.order("name").page(params[:page]).per_page(5)

  end


  #def search
   # @products = Product.search(params[:name])
    #if !@products.blank? 
     # render template: "products/search"    
    #else
     # redirect_to action: 'index'
    #end
    #redirect_to search_path(params[:search])
  #end

  def show
    
    @product = Product.find(params[:id])     
        
    #render for view format 
    #render json: @product
    #render xml: @product
  end  

  def create
   @product = Product.new(params[:id])
  
    if @product.save      
      redirect_to action: 'index' , notice: 'Product was sucessful created'
    else
      render action: 'new', alert: 'Product could not be create', :layout => false
    end    
  end

  def new
    @product = Product.new
  end

  private
  def set_product
    @product = Product.find(params[:id])  
  end

  def product_params
    params.require(:product).permit(:name, :price)
  end  
end