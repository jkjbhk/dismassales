class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :item
  attr_accessible :quantity
end
