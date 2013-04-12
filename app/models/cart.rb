class Cart < ActiveRecord::Base
	attr_accessible :sessionid

	has_many :cart_items, :dependent => :destroy, :autosave => :true, :order => 'id'

	validates_associated :cart_items

	#store the cart in a relational database is not a good solution for high traffic web sites
	#it would be way to slow
	#in a commercial application some kind of cache should be implemented, or use some kind of no-sql database
	#the user can have an empty cart, but can't checkout with it
	def self.createOrFind(sessionid)
		existentcart = Cart.where("sessionid = ?", sessionid)
		
		cart = existentcart.first
		if !cart
			cart = Cart.new(sessionid: sessionid)
			cart.save
		end
		cart
	end

    #find all items for the current cart, searching for sessionid
	#return as an array of item
	def self.findItems(sessionid)
		cart = Cart.where("sessionid = ?", sessionid).first
		itemsReturn = Array.new
		cart.cart_items.each do |cart_item| 
		  itemsReturn.push cart_item.item
		end
		itemsReturn
	end

	def self.UpdateQuantities(cart, quantities)
		# do one or do all
		Cart.transaction do
		  quantities.each do |key, value|
		    cart.cart_items.each do |cart_item|
		      if cart_item.id == key.to_i
		        cart_item.quantity = value.to_i;
		      end
		    end  
		  end

		  cart.save;
		end
	cart
	end

	def self.howMuchItems(sessionid)
		cart = createOrFind(sessionid);
		count = CartItem.count(:conditions => ["cart_id = ?", cart.id])
		count
	end

	def calculateTotalValue
		totalValue = 0;
		cart_items.each do |cart_item|
			totalValue = totalValue + (cart_item.item.price * cart_item.quantity)
		end
		totalValue
	end
end
