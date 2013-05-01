# implementation of the design item 7 -­ Create New Address and 9 -­ Order completed

# there is some unused code right now, but it will be used in the orders hstory later

class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.findByFilter(params)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @order = Order.new

    @howmuchitems = Cart.howMuchItems(request.session_options[:id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.json
  def create
    cart = Cart.createOrFind(request.session_options[:id])
    @order = Order.createFromCart(params[:order], cart)

    @howmuchitems = Cart.howMuchItems(request.session_options[:id])

    if @order.errors.size < 1
      reset_session
    end

    respond_to do |format|
      if @order.errors.size < 1
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def detail
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @order }
    end
  end

  def shiporder
    @order = Order.find(params[:id])
    @order.shipping_date = Date.today
    @order.save

    redirect_to order_detail_path(@order)
  end
end
