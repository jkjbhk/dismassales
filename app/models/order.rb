# implementation of the design item 7 -­ Create New Address and 9 -­ Order completed

class Order < ActiveRecord::Base
	attr_accessible :address1, :address2, :city, :name, :state, :surname, :zip, :date_created, :shipping_date

	has_many :order_items, :dependent => :destroy, :autosave => :true, :order => 'id'

	validates :address1, :city, :name, :state, :surname, :zip, :presence => true

 	def self.createFromCart(params, cart)
 		order = Order.new(params)
 		order.date_created = Date.today
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

	def self.createFromCartAndPaypal(params, cart, gateway_response)
 		order = Order.new
 		order.address1 = gateway_response.params['street1']
 		order.address2 = gateway_response.params['street2']
 		order.city = gateway_response.params['city_name']
 		order.zip = gateway_response.params['postal_code']
 		order.state = gateway_response.params['state_or_province']
 		order.name = gateway_response.params['first_name']
 		order.surname = gateway_response.params['last_name']
 		order.date_created = Date.today
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

	def self.findByFilter(params)
		orders = Order.where("")

		if params['number'] != nil && params['number'] != ''
			orders = orders.where("id = ?", params['number'])
		end

		if params['created1'] != nil && params['created1'] != ''
			orders = orders.where("date_created >= ?", Date.parse(params['created1'])) 
		end

		if params['created2'] != nil && params['created2'] != ''
			orders = orders.where("date_created <= ?", Date.parse(params['created2'])) 
		end

		if params['open'] != nil && params['open'] != '' && params['shipped'] != nil && params['shipped'] != ''

			if params['open'] == nil || params['open'] == ''
				orders = orders.where("shipping_date is not null") 
			end

			if params['shipped'] == nil || params['shipped'] == ''
				orders = orders.where("shipping_date is null") 
			end

		end

		if params['shipped1'] != nil && params['shipped1'] != ''
			orders = orders.where("shipping_date >= ?", Date.parse(params['shipped1'])) 
		end

		if params['shipped2'] != nil && params['shipped2'] != ''
			orders = orders.where("shipping_date <= ?", Date.parse(params['shipped2'])) 
		end

		if params['name'] != nil && params['name'] != ''
			orders = orders.where("name like ?", params['name'])
		end

		orders
	end
end
