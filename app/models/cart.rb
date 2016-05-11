
class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  def subtotal
    #SQL version of summing, which is faster than Ruby
    line_items.select("SUM(quantity * price) AS sum")[0].sum

    #Ruby version of summing
    # line_items.to_a.sum{ |item| item.total }
  end

  def add_product(product_id)
    product = Product.find(product_id)

    # Find out if the item is already in the cart; if it doesn't exist, its value is nil
    current_item = line_items.find_by(product_id: product_id)

    #If the current item does exist, increase quantity. If not, build new line item
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product: product, price: product.price)
    end
    current_item
  end

end