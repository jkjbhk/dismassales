# implementation of the design item 3 ­ Item Detail screen

class ItemdetailController < ApplicationController
  def index
    @item = Item.find(params[:id])
    @categories = Category.all
    @howmuchitems = Cart.howMuchItems(request.session_options[:id])

    respond_to do |format|
      format.html
      format.json { render json: @item }
    end
  end

  def image
  	@item_image = ItemImage.find(params[:id])

    respond_to do |format|
      format.html {render "itemimage"}
      format.json { render json: @item }
    end
  end
end
