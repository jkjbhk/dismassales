class ItemImage < ActiveRecord::Base
  attr_accessible :image, :item_id

  belongs_to :item

  has_attached_file :image, :styles => { :medium => "156x192>", :thumb => "150x120>" }, :default_url => "/images/:style/missing.png"
end
