class Cart < ActiveRecord::Base
	has_many :line_items , dependent: :destroy

	#add product to cart
	def add_product(product_id)
		#get pdoduct iten current 
		# neu da co item product trong cart thif so luong item tang len 1
		current_item = line_items.find_by(product_id: product_id)
		if current_item
			current_item.quantity += 1
		#nguoc lai thi bat dau add product vao 
		else			
			current_item = line_items.build(product_id: product_id)

		end
		current_item
	end

	def total_price
    	line_items.to_a.sum { |item| item.total_price }
  end	
end
