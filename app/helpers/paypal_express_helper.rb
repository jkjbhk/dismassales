module PaypalExpressHelper
  def get_setup_purchase_params(cart, request)
    subtotal, shipping, total = get_totals(cart)
    return to_cents(total), {
      :ip => request.remote_ip,
      :return_url => url_for(:action => 'review', :only_path => false),
      :cancel_return_url => 'http://localhost:3000/store/shoppingcart',
      :subtotal => to_cents(subtotal),
      :shipping => to_cents(shipping),
      :handling => 0,
      :tax =>      0,
      :allow_note =>  true,
      :items => get_items(cart),
    }
  end
 
  def get_shipping(cart)
    # define your own shipping rule based on your cart here
    # this method should return an integer
  end
 
  def get_items(cart)
    cart.cart_items.collect do |cart_item|
      item = cart_item.item
 
      {
        :name => item.title, 
        :number => item.code, 
        :quantity => cart_item.quantity, 
        :amount => to_cents(item.price), 
      }
    end
  end

  def get_order_info(gateway_response, cart)
    subtotal, shipping, total = get_totals(cart)
    {
      shipping_address: gateway_response.address,
      email: gateway_response.email,
      name: gateway_response.name,
      gateway_details: {
        :token => gateway_response.token,
        :payer_id => gateway_response.payer_id,
      },
      subtotal: subtotal,
      shipping: shipping,
      total: total,
    }
  end
 
  def get_totals(cart)
    subtotal = cart.calculateTotalValue
    #I will have no time to implement the shipping price maintenance
    #shipping = get_shipping(cart)
    shipping = 5
    total = subtotal + shipping
    return subtotal, shipping, total
  end
 
  def to_cents(money)
    (money*100).round
  end

  def get_purchase_params(cart, request, params)
    subtotal, shipping, total = get_totals(cart)
    return to_cents(total), {
      :ip => request.remote_ip,
      :token => params[:token],
      :payer_id => params[:payer_id],
      :subtotal => to_cents(subtotal),
      :shipping => to_cents(shipping),
      :handling => 0,
      :tax =>      0,
      :items =>    get_items(cart),
    }
  end
end