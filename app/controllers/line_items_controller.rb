class LineItemsController < ApplicationController

include CurrentCart
before_action :set_cart

	def create
		product = Product.find(params[:product_id])
		@line_item = @cart.line_items.build(product: product, price: product.price)
	end

	if @line_item.save
		flash[:notice] = "#{product.name} was added to your cart!"
		redirect_to shop_path
	else
		flash.now[:alert] = "could not add this item to your cart"
	end
end


end
