class CartItem < ActiveRecord::Base
	attr_accessible :cart, :item, :quantity

	belongs_to :cart
	belongs_to :item

	validates :quantity, :numericality => { :only_integer => true}

	validates :cart_id, :item_id, :quantity, :presence => true

	validates :quantity, :numericality => { :greater_than_or_equal_to => 1}

	def self.createCartItem(item, cart, quantity)
		cart_item = CartItem.new
		cart_item.cart = cart
		cart_item.item = item
		cart_item.quantity = quantity;
		cart_item.save
	end
end
