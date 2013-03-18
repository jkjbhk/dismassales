class ItemImage < ActiveRecord::Base
  attr_accessible :image, :item_id

  belongs_to :item

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "200x200>" }, :default_url => "/images/:style/missing.png"
end
