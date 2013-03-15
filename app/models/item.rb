class Item < ActiveRecord::Base
  belongs_to :category
  attr_accessible :code, :description, :enabled, :price, :show_on_home, :title, :category_id
end
