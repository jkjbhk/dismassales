class Item < ActiveRecord::Base
  belongs_to :category
  attr_accessible :code, :description, :enabled, :price, :show_on_home, :title, :category_id
  has_many :item_images

  def self.home_items
  	items = Item.where("show_on_home = ?", true);
  	items
  end
end
