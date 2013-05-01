class PaypalExpressController < ApplicationController
 	before_filter :assigns_gateway
 
	include ActiveMerchant::Billing
	include PaypalExpressHelper
 
	def checkout
	    @cart = Cart.createOrFind(request.session_options[:id])

		total_as_cents, setup_purchase_params = get_setup_purchase_params @cart, request
		setup_response = @gateway.setup_purchase(total_as_cents, setup_purchase_params)
		redirect_to @gateway.redirect_url_for(setup_response.token)
	end

	def review
	    if params[:token].nil?
	      redirect_to home_url, :notice => 'Woops! Something went wrong!' 
	      return
	    end
	 
	    gateway_response = @gateway.details_for(params[:token])
	 
	    unless gateway_response.success?
	      redirect_to home_url, :notice => "Sorry! Something went wrong with the Paypal purchase. Here's what Paypal said: #{gateway_response.message}" 
	      return
	    end

	    @cart = Cart.createOrFind(request.session_options[:id])

	    @howmuchitems = Cart.howMuchItems(request.session_options[:id])
	 
	    @order_info = get_order_info gateway_response, @cart
	  end

	def purchase
	    if params[:token].nil? or params[:payer_id].nil?
	      redirect_to home_url, :notice => "Sorry! Something went wrong with the Paypal purchase. Please try again later." 
	      return
	    end

	    @cart = Cart.createOrFind(request.session_options[:id])
	 
	    total_as_cents, purchase_params = get_purchase_params @cart, request, params
	    purchase = @gateway.purchase total_as_cents, purchase_params
	 
	    if purchase.success?

		  @order = Order.createFromCartAndPaypal(params[:order], @cart, @gateway.details_for(params[:token]))

	      reset_session

	      @howmuchitems = Cart.howMuchItems(request.session_options[:id])

	      # you might want to destroy your cart here if you have a shopping cart 
      	  redirect_to :controller => 'orders', :action => 'show', :id => @order.id
	    else
	      notice = "Woops. Something went wrong while we were trying to complete the purchase with Paypal. Btw, here's what Paypal said: #{purchase.message}"
	      redirect_to shoppingcart_url, :notice => notice
	    end
	 
	  end
 
	private
		def assigns_gateway
			@gateway ||= PaypalExpressGateway.new(
				:login => Settings.login,
				:password => Settings.password,
				:signature => Settings.signature,
			)
	end
end
