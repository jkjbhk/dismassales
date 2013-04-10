class Order < ActiveRecord::Base
	attr_accessible :address1, :address2, :city, :name, :state, :surname, :zip

	has_many :order_items, :dependent => :destroy, :autosave => :true, :order => 'id'

	validates :address1, :city, :name, :state, :surname, :zip, :presence => true

 	def self.createFromCart(params, cart)
 		order = Order.new(params)
 		order.save
 		if order.errors.size < 1
 			cart.cart_items.each do |cart_item|
	 			order_item = OrderItem.new
	 			order_item.item = cart_item.item;
	 			order_item.order = order;
	 			order_item.quantity = cart_item.quantity;
	 			order_item.save
	 		end
	 		order.reload
 		end
 		order
	end
end
