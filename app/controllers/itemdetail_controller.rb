class ItemdetailController < ApplicationController
  def index
    @item = Item.find(params[:id])
    @categories = Category.all

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end
end
