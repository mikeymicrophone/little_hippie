class Cart < ActiveRecord::Base
  belongs_to :customer
  belongs_to :shipping_address # the shipping address assigned to the cart
  has_many :shipping_addresses # any shipping addresses created during checkout for this cart
  has_many :items
  has_many :charges
  attr_accessible :status, :customer, :ip_address, :gift_note
  scope :complete, :conditions => {:status => 1}
  
  
  def subtotal
    items.inject(0) { |sum, item| sum + item.cost } + shipping_charge
  end
  
  def shipping_charge
    case item_quantity
    when 0
      0
    when 1
      575
    when 2..5
      575 + (200 * (item_quantity - 1))
    when 6..10
      1375 + (150 * (item_quantity - 5))
    else
      2125 + (100 * (item_quantity - 10))
    end / 100.0
  end
  
  def item_quantity
    items.sum :quantity
  end
  
  def apparent_primary_shipping_address
    if shipping_address.present?
      shipping_address
    else
      shipping_addresses.last
    end
  end
end
