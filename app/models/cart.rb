class Cart < ActiveRecord::Base
	has_many :line_items, dependant: :destroy

	def subtotal
		line_items.select("SUM(quantity * price) AS sum")[0].sum 

		# line_items.to_a.sum{ |item| item.total }
	end
end
