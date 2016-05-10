class LineItemsController < ApplicationController

include CurrentCart
before_action :set_cart

	def create
		product = Product.find(params[:product_id])
		@line_item = @cart.add_product(product.id)
	end

	if @line_item.save
		flash[:notice] = "#{product.name} was added to your cart!"
		redirect_to shop_path
	else
		flash.now[:alert] = "could not add this item to your cart"
	end
end

def destroy
	@line_item = @cart.line.line_items.find(params[:id])
	if @line_item.destroy
	redirect_to edit_cart_path(@cart), notice: "Item removed from cart"
	else
		redirect_to @cart, alert: "could not remove from cart."
	end	
end

def update
	@line_item = @cart.line_items.find(params[:id])
	if @line_item.quantity <= 0
		@line_item.destroy
		redirect_to edit_cart_path(@cart), notice: "Item removed from cart"
	elsif  @line_item.update(line_item_params)
		redirect_to edit_cart_path(@cart), notice: "#{@line_item.product.name} quantity updated"
	else
		redirect_to edit_cart_path(@cart), alert: "could not update quantity"
	end
end

private

def line_item_params
	params.require(:line_item).permit(:quantity)
end
