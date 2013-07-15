class Cart < ActiveRecord::Base
  belongs_to :customer
  belongs_to :shipping_address # the shipping address assigned to the cart
  has_many :shipping_addresses # any shipping addresses created during checkout for this cart
  has_many :items
  has_many :charges
  attr_accessible :status, :customer, :ip_address, :gift_note, :tracking_number, :referral_type
  scope :complete, :conditions => {:status => 1}
  attr_accessor :coupon
  
  def subtotal
    items.inject(0) { |sum, item| sum + item.cost } + shipping_charge
  end
  
  def subtotal_after_coupon
    if coupon.andand.percentage.present?
      coupon_rate = (100 - coupon.percentage) / 100.0
      if coupon.upper_limit.present?
        return subtotal if subtotal * 100 > coupon.upper_limit
      end
      items.inject(0) { |sum, item| sum + (item.cost * coupon_rate) } + shipping_charge
    elsif coupon.andand.amount.present?
      if coupon.lower_limit.present?
        return subtotal if subtotal * 100 < coupon.lower_limit
      end
      (items.inject(0) { |sum, item| sum + item.cost } + shipping_charge) - (coupon.amount / 100.0)
    else
      items.inject(0) { |sum, item| sum + item.cost } + shipping_charge
    end
  end
  
  def discount_amount
    self.coupon ||= charges.first.andand.coupon
    subtotal - subtotal_after_coupon
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
  
  def update_inventory
    items.each do |item|
      garment = item.garment
      garment.andand.inventory.andand.update_attribute :current_amount, garment.andand.inventory.andand.current_amount.andand.-(item.quantity)
    end
  end
end
