# implementation of the design item 7 -­ Create New Address and 9 -­ Order completed

class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :item
  attr_accessible :quantity
end
