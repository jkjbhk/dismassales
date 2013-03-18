class StorefrontController < ApplicationController
  def index
    @items = Item.home_items

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end
end
