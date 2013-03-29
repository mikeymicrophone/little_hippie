class Cart < ActiveRecord::Base
  belongs_to :customer
  belongs_to :shipping_address # the shipping address assigned to the cart
  has_many :shipping_addresses # any shipping addresses created during checkout for this cart
  has_many :items
  has_many :charges
  attr_accessible :status, :customer, :ip_address
  scope :complete, :conditions => {:status => 1}
  
  
  def subtotal
    items.inject(0) { |sum, item| sum + item.cost }
  end
  
  def apparent_primary_shipping_address
    if shipping_address.present?
      shipping_address
    else
      shipping_addresses.last
    end
  end
end
