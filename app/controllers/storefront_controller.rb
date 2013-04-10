# implementation of the design item 2 ­ Store Home screen

class StorefrontController < ApplicationController
  def index
    @items = Item.home_items(params[:category_id])
    @categories = Category.all
    @howmuchitems = Cart.howMuchItems(request.session_options[:id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end
end
