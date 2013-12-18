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
    items.inject(0) { |sum, item| sum + item.cost }
  end
  
  def total
    subtotal_after_coupon + shipping_charge
  end
  
  def subtotal_after_coupon
    if coupon.andand.percentage.present?
      coupon_rate = (100 - coupon.percentage) / 100.0
      if coupon.upper_limit.present?
        return total if total * 100 > coupon.upper_limit
      end
      items.inject(0) do |sum, item|
        if coupon.valid_for? item.product
          item_cost = item.cost * coupon_rate
        else
          item_cost = item.cost
        end
        sum + item_cost
      end
    elsif coupon.andand.amount.present?
      if coupon.lower_limit.present?
        return total if total * 100 < coupon.lower_limit
      end
      if items.map(&:product).any? { |product| coupon.valid_for? product }
        subtotal - (coupon.amount / 100.0)
      else
        subtotal
      end
    else
      subtotal
    end
  end
  
  def discount_amount
    self.coupon ||= charges.last.andand.coupon
    total - subtotal_after_coupon
  end
  
  def shipping_charge
    case subtotal * 100
    when (0..999)
      595
    when (1000..1999)
      695
    when (2000..2999)
      795
    when (3000..3999)
      995
    when (4000..4999)
      1095
    when (5000..5999)
      1195
    when (6000..7999)
      1295
    when (8000..9999)
      1495
    when (10000..14999)
      1695
    when (15000..19999)
      2595
    when (20000..24999)
      3095
    when (25000..29999)
      3595
    when (30000..34999)
      4095
    when (35000..39999)
      4595
    when (40000..44999)
      5095
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
