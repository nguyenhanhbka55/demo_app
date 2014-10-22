class LineItemsController < ApplicationController

  #/concern/current_cart.rb
  include CurrentCart

  before_action :set_cart, only: [:create]
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  def index
    @line_items = LineItem.all
  end

 
  def show
  end

  
  def new
    @line_item = LineItem.new
  end

 
  def edit
  end

  
  def create
    #get product_id 
    product = Product.find(params[:product_id])

    #@line_item = @cart.line_items.build(product: product)
    @line_item = @cart.add_product(product.id)
    if @line_item.save                
        render :show
        flash[:notice]  = 'Line item was successfully created'        

    else
        render :action => 'new'             
    end
    
  end

  
  def update    
      if @line_item.update(line_item_params)
        render :show, notice: 'Line item was successfully updated.'        
      else
       render :edit
      end    
  end

  
  def destroy
    @line_item.destroy
      redirect_to line_items_url
      flash[:notice] = 'Line item was successfully destroyed'          
  end

  private    
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end
    
    def line_item_params
      params.require(:line_item).permit(:product_id)
    end
end