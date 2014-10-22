class Product < ActiveRecord::Base	
	
	has_many :line_items
	validates :page, presence: true
	validates :description, presence: true
	validates :name, :image_url, presence: true
	validates :price, numericality: {greater_than_or_equal_to: 0.01}
	validates :image_url, allow_blank: true, format: {
    	with:    %r{\.(gif|jpg|png)\Z}i,
    	message: 'must be a URL for GIF, JPG or PNG image.'
  	}
end
#WillPaginate.per_page = 5