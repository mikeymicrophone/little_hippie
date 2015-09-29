class Cart < ActiveRecord::Base
  belongs_to :customer
  belongs_to :shipping_address # the shipping address assigned to the cart
  has_many :shipping_addresses # any shipping addresses created during checkout for this cart
  has_many :items, :dependent => :destroy
  has_many :products, :through => :items
  has_many :charges, :dependent => :destroy
  belongs_to :coupon
  attr_accessible :status, :customer, :ip_address, :gift_note, :tracking_number, :referral_type, :shipping_method
  scope :complete, where({:status => [1, 2]})
  scope :unpurchased, where({:status => nil})
  scope :untracked, where({:tracking_number => nil})
  scope :pertinent_to_old_glory, lambda { joins(:products).merge(Product.shipped_by(1)) }
  attr_accessor :sale
  
  STANDARD_SHIPPING = 1
  RUSH_SHIPPING = 2
  EXPEDITED_SHIPPING = 3
  
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
  
  def charge
    charges.last
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
  
  def subtotal_after_sale
    items.inject(0) { |sum, item| sum + item.final_cost }
  end
  
  def total
    subtotal_after_coupon + (coupon.andand.free_shipping? ? 0 : shipping_charge)
  end
  
  def subtotal_after_coupon
    if coupon.andand.percentage.present?
      coupon_rate = (100 - coupon.percentage) / 100.0
      if coupon.upper_limit.present?
        return subtotal_after_sale if subtotal_after_sale * 100 > coupon.upper_limit
      end
      items.inject(0) do |sum, item|
        if coupon.valid_for? item.product
          item_cost = item.final_cost * coupon_rate
        else
          item_cost = item.final_cost
        end
        sum + item_cost
      end
    elsif coupon.andand.amount.present?
      if coupon.lower_limit.present?
        return subtotal_after_sale if subtotal_after_sale * 100 < coupon.lower_limit
      end
      if items.map(&:product).any? { |product| coupon.valid_for? product }
        price = subtotal_after_sale - (coupon.amount / 100.0)
        if price < 1.0
          1.0
        else
          price
        end
      else
        subtotal_after_sale
      end
    else
      subtotal_after_sale
    end
  end
  
  def total_before_sale
    subtotal + shipping_charge
  end
  
  def total_before_coupon
    subtotal_after_sale + shipping_charge
  end
  
  def total_after_coupon
    total
  end
  
  def tax_total
    tax_is_due? ? connecticut_tax : 0
  end
  
  def connecticut_tax
    total * 0.0635
  end
  
  def total_with_connecticut_tax
    total + connecticut_tax
  end
  
  def total_after_tax
    if tax_is_due?
      total + connecticut_tax
    else
      total
    end
  end
  
  def tax_is_due?
    apparent_primary_shipping_address.andand.state == State.connecticut
  end
  
  def discount_amount
    self.coupon ||= charges.last.andand.coupon
    total_before_sale - total_after_coupon
  end
  
  def shipping_charge
    if domestic?
      domestic_shipping_rate
    elsif canada?
      canada_shipping_rate
    elsif international?
      international_shipping_rate
    else
      Rails.logger.error "Not able to identify shipping destination country."
      domestic_shipping_rate
    end
  end
  
  def domestic_shipping_rate
    self.shipping_method ||= STANDARD_SHIPPING
    
    pins = items.select { |item| item.product.pin? }
    
    pin_shipping = pins.map(&:quantity).sum * 250
    
    non_pin_total = subtotal_after_coupon - pins.map(&:cost).sum
    puts non_pin_total
    non_pin_shipping = case non_pin_total * 100
    when (-999999999..-1)
      case shipping_method
      when STANDARD_SHIPPING
        595
      when RUSH_SHIPPING
        1395
      when EXPEDITED_SHIPPING
        2595
      end
    when 0
      0
    when (1..999)
      case shipping_method
      when STANDARD_SHIPPING
        595
      when RUSH_SHIPPING
        1395
      when EXPEDITED_SHIPPING
        2595
      end
    when (1000..1999)
      case shipping_method
      when STANDARD_SHIPPING
        695
      when RUSH_SHIPPING
        1495
      when EXPEDITED_SHIPPING
        2695
      end
    when (2000..2999)
      case shipping_method
      when STANDARD_SHIPPING
        795
      when RUSH_SHIPPING
        1595
      when EXPEDITED_SHIPPING
        2795
      end
    when (3000..3999)
      case shipping_method
      when STANDARD_SHIPPING
        995
      when RUSH_SHIPPING
        1795
      when EXPEDITED_SHIPPING
        2995
      end
    when (4000..4999)
      case shipping_method
      when STANDARD_SHIPPING
        1095
      when RUSH_SHIPPING
        1895
      when EXPEDITED_SHIPPING
        3095
      end
    when (5000..5999)
      case shipping_method
      when STANDARD_SHIPPING
        1195
      when RUSH_SHIPPING
        1995
      when EXPEDITED_SHIPPING
        3195
      end
    when (6000..7999)
      case shipping_method
      when STANDARD_SHIPPING
        1295
      when RUSH_SHIPPING
        2095
      when EXPEDITED_SHIPPING
        3295
      end
    when (8000..9999)
      case shipping_method
      when STANDARD_SHIPPING
        1495
      when RUSH_SHIPPING
        2295
      when EXPEDITED_SHIPPING
        3495
      end
    when (10000..14999)
      case shipping_method
      when STANDARD_SHIPPING
        1695
      when RUSH_SHIPPING
        2495
      when EXPEDITED_SHIPPING
        3695
      end
    when (15000..19999)
      case shipping_method
      when STANDARD_SHIPPING
        2595
      when RUSH_SHIPPING
        3395
      when EXPEDITED_SHIPPING
        4595
      end
    when (20000..24999)
      case shipping_method
      when STANDARD_SHIPPING
        3095
      when RUSH_SHIPPING
        3895
      when EXPEDITED_SHIPPING
        5095
      end
    when (25000..29999)
      case shipping_method
      when STANDARD_SHIPPING
        3595
      when RUSH_SHIPPING
        4395
      when EXPEDITED_SHIPPING
        5595
      end
    when (30000..34999)
      case shipping_method
      when STANDARD_SHIPPING
        4095
      when RUSH_SHIPPING
        4895
      when EXPEDITED_SHIPPING
        6095
      end
    when (35000..39999)
      case shipping_method
      when STANDARD_SHIPPING
        4595
      when RUSH_SHIPPING
        5395
      when EXPEDITED_SHIPPING
        6595
      end
    else
      case shipping_method
      when STANDARD_SHIPPING
        5095
      when RUSH_SHIPPING
        5895
      when EXPEDITED_SHIPPING
        7095
      end
    end 
    (pin_shipping + non_pin_shipping) / 100.0
  end
  
  def canada_shipping_rate
    case pounds.ceil
    when 1
      2695
    when 2
      3195
    when 3
      3895
    when 4
      4295
    when 5
      4995
    when 6
      5995
    when 7
      6495
    when 8
      6995
    when 9
      7495
    when 10
      7995
    when 11
      8495
    when 12
      8995
    when 13
      9995
    when 14
      10495
    when 15
      10995
    when 16
      11995
    when 17
      12495
    when 18
      12995
    when 19
      13495
    when 20
      13995
    when 21
      14495
    when 22
      14995
    when 23
      15495
    when 24
      15995
    when 25
      16995
    when 26
      17995
    when 27
      18995
    when 28
      19995
    when 29
      20495
    when 30
      21995
    else
      22495
    end / 100.0
  end
  
  def international_shipping_rate
    case pounds.ceil
    when 1
      1995
    when 2
      2695
    when 3
      3295
    when 4
      3995
    when 5
      4395
    when 6
      4995
    when 7
      5595
    when 8
      6095
    when 9
      6695
    when 10
      7195
    when 11
      7695
    when 12
      8095
    when 13
      8595
    when 14
      8995
    when 15
      9495
    when 16
      9995
    when 17
      10695
    when 18
      11395
    when 19
      11795
    when 20
      12395
    when 21
      12995
    when 22
      13495
    when 23
      14095
    when 24
      14595
    when 25
      15095
    when 26
      15495
    when 27
      15995
    when 28
      16395
    when 29
      16895
    when 30
      17495
    else
      18095
    end / 100.0
  end
  
  def freeze_item_prices
    items.each do |item|
      item.update_attribute :final_price, item.final_cost * 100
    end
  end
  
  def shipping_method_name
    if domestic?
      case shipping_method
      when STANDARD_SHIPPING
        'Standard'
      when RUSH_SHIPPING
        'Rush'
      when EXPEDITED_SHIPPING
        'Expedited'
      end
    elsif canada?
      'Canada'
    elsif international?
      'Internation Air'
    end
  end
  
  def domestic?
    apparent_primary_shipping_address.nil? || apparent_primary_shipping_address.country == Country.united_states
  end
  
  def canada?
    apparent_primary_shipping_address.country == Country.canada
  end
  
  def international?
    !domestic? && !canada?
  end
  
  def item_quantity
    items.sum :quantity
  end
  
  def ounces
    items.inject(0) { |sum, item| sum + item.quantity * item.body_style_size.weight }
  end
  
  def pounds
    ounces / 16.0
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
      item.garment.andand.decrement_inventory! item.quantity
    end
  end
  
  def to_mww_xml
    builder = ::Builder::XmlMarkup.new
    builder.instruct!
    builder.soap :Envelope, 'xmlns:xsi' => "http://www.w3.org/2001/XMLSchema-instance", 'xmlns:xsd' => "http://www.w3.org/2001/XMLSchema", 'xmlns:soap' => "http://schemas.xmlsoap.org/soap/envelope/" do
      builder.soap :Body do
        builder.InsertOrder 'xmlns' => "http://tempuri.org/" do
          builder.vendorName "LittleHippieLlc"
          builder.password ENV['MWW_API_PASSWORD']
          builder.webOrderXML do
            builder.OrderID charge.id
            builder.OrderType 'test' #'new'
            builder.ProjectCode
            builder.ProjectShipDate Date.today + 5.days
            builder.RetailerPO
            builder.LineItems do
              items.mww.each_with_index do |item, index|
                item.to_mww_xml builder, index
              end
            end
            builder.CustomerBillingInfo do
              builder.Name 'Little Hippie LLC'
              builder.Address1 '949 Willoughby Ave'
              builder.Address2 'Apt 208'
              builder.City 'Brooklyn'
              builder.State 'NY'
              builder.PostalCode 11206
              builder.Country 'US'
              builder.Phone
            end
            builder.CustomerShippingInfo do
              builder.Name apparent_primary_shipping_address.full_name
              builder.Address1 apparent_primary_shipping_address.street
              builder.Address2 apparent_primary_shipping_address.street2
              builder.City apparent_primary_shipping_address.city
              builder.State apparent_primary_shipping_address.state.iso
              builder.PostalCode apparent_primary_shipping_address.zip
              builder.Country apparent_primary_shipping_address.country.iso
              builder.ShippingMethod 'UPSGROUND'
              builder.ShipAccountNum ENV['SHIPPING_ACCOUNT_NUMBER']
              builder.ShipType 'MTH'
              builder.DC
            end
            builder.OrderProperties
          end
        end
      end
    end
  end
end
