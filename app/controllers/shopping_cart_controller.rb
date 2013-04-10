class ShoppingCartController < ApplicationController

	def index
		@cart = Cart.createOrFind(request.session_options[:id])
		@howmuchitems = Cart.howMuchItems(request.session_options[:id])

		respond_to do |format|
	      format.html
	    end
	end

	def addtocart
		cart = Cart.createOrFind(request.session_options[:id])

		item = Item.find(params[:item_id])

    	CartItem.createCartItem(item, cart, params[:quantity].to_i);

		respond_to do |format|
	    	format.html { redirect_to shoppingcart_url }
	    end
	end

	def updatecart
		@cart = Cart.createOrFind(request.session_options[:id])

		@howmuchitems = Cart.howMuchItems(request.session_options[:id])

		items_to_be_updated = Hash.new

	    #parse parameters
	    params.each do |key, value|
	      if key.start_with?('quantity_')
	        items_to_be_updated[key[9..key.length-1]] = value;
	      end
	      
	    end;
	    
	    @cart = Cart.UpdateQuantities(@cart, items_to_be_updated);

	    respond_to do |format|
	      format.html { render :action => "index" }
	      format.json { render json: @cart }
	    end
	end

	def removeitem
		cart_item = CartItem.find(params[:id])
		cart_item.destroy

		@cart = Cart.createOrFind(request.session_options[:id])
		
		respond_to do |format|
	      format.html { render :action => "index" }
	    end
	end
end
