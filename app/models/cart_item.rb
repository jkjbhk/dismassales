# implementation of the design item 4 -­ Shopping Cart

class CartItem < ActiveRecord::Base
	attr_accessible :cart, :item, :quantity

	belongs_to :cart
	belongs_to :item

	validates :quantity, :numericality => { :only_integer => true}

	validates :cart_id, :item_id, :quantity, :presence => true

	validates :quantity, :numericality => { :greater_than_or_equal_to => 1}

	def self.createCartItem(item, cart, quantity)
		cart_item = CartItem.where("item_id = ?", item.id).where("cart_id = ?", cart.id).first
		#if the item does not exist in the cart, create a new register, if it already exists update the existent
		if cart_item == nil
			cart_item = CartItem.new
			cart_item.cart = cart
			cart_item.item = item
			cart_item.quantity = quantity;
			cart_item.save
		else
			cart_item.quantity = cart_item.quantity + quantity;
			cart_item.save
		end
	end
end
