class Cart < ActiveRecord::Base
  belongs_to :customer
  has_many :items
  has_many :charges
  attr_accessible :status, :customer
  
  def subtotal
    items.inject(0) { |sum, item| sum + item.product.dollar_price }
  end
end
