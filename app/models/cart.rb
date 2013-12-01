class Cart < ActiveRecord::Base
  belongs_to :customer
  belongs_to :shipping_address # the shipping address assigned to the cart
  has_many :shipping_addresses # any shipping addresses created during checkout for this cart
  has_many :items, :dependent => :destroy
  has_many :charges, :dependent => :destroy
  belongs_to :coupon
  attr_accessible :status, :customer, :ip_address, :gift_note, :tracking_number, :referral_type
  scope :complete, where({:status => [1, 2]})
  scope :unpurchased, where({:status => nil})
  
  before_update :update_shipment_status
  
  def status_word
    case status
    when 1
      'paid'
    when 2
      'shipped'
    else
      'not purchased'
    end
  end
  
  def unpurchased?
    status.nil?
  end
  
  def update_shipment_status
    if tracking_number.present?
      self.status = 2
    end
  end
  
  def subtotal
    items.inject(0) { |sum, item| sum + item.cost } + shipping_charge
  end
  
  def subtotal_after_coupon
    if coupon.andand.percentage.present?
      coupon_rate = (100 - coupon.percentage) / 100.0
      if coupon.upper_limit.present?
        return subtotal if subtotal * 100 > coupon.upper_limit
      end
      items.inject(0) do |sum, item|
        if coupon.valid_for? item.product
          item_cost = item.cost * coupon_rate
        else
          item_cost = item.cost
        end
        sum + item_cost
      end + (coupon.free_shipping? ? 0 : shipping_charge)
    elsif coupon.andand.amount.present?
      if coupon.lower_limit.present?
        return subtotal if subtotal * 100 < coupon.lower_limit
      end
      if items.map(&:product).any? { |product| coupon.valid_for? product }
        (items.inject(0) { |sum, item| sum + item.cost } + (coupon.free_shipping? ? 0 : shipping_charge)) - (coupon.amount / 100.0)
      else
        items.inject(0) { |sum, item| sum + item.cost } + (coupon.free_shipping? ? 0 : shipping_charge)
      end
    else
      items.inject(0) { |sum, item| sum + item.cost } + (coupon.andand.free_shipping? ? 0 : shipping_charge)
    end
  end
  
  def discount_amount
    self.coupon ||= charges.last.andand.coupon
    subtotal - subtotal_after_coupon
  end
  
  def shipping_charge
    base_charge = case item_quantity
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
    end
    blanket_surcharge = items.blanket.count * 900
    (base_charge + blanket_surcharge) / 100.0
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
