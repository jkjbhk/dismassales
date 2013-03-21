#implementation of the design item 2 ­ Store Home screen and 3 ­ Item Detail screen and 15 ­ Item Maintenance ­ Detail

class Item < ActiveRecord::Base
  belongs_to :category
  attr_accessible :code, :description, :enabled, :price, :show_on_home, :title, :category_id
  has_many :item_images

  def self.home_items(category_id)
  	# if there is filter for category, filter for this category, else shows the home items
  	if category_id != nil
  		items = Item.where("category_id = ?", category_id);
  	else
  		items = Item.where("show_on_home = ?", true);
  	end
  	items
  end
end
