# implementation of the design item 7 -­ Create New Address and 9 -­ Order completed

class Order < ActiveRecord::Base
	attr_accessible :address1, :address2, :city, :name, :state, :surname, :zip

	has_many :order_items, :dependent => :destroy, :autosave => :true, :order => 'id'

	validates :address1, :city, :name, :state, :surname, :zip, :presence => true

 	def self.createFromCart(params, cart)
 		order = Order.new(params)
 		order.save
 		#the .save method dont throws exeptions, just save errors. Just proceed if no error happened
 		if order.errors.size < 1
 			cart.cart_items.each do |cart_item|
	 			order_item = OrderItem.new
	 			order_item.item = cart_item.item;
	 			order_item.order = order;
	 			order_item.quantity = cart_item.quantity;
	 			order_item.save
	 		end
	 		#reload all the values from the database, list the new order_item
	 		order.reload
 		end
 		order
	end
end
