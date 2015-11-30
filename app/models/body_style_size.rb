class BodyStyleSize < ActiveRecord::Base
  belongs_to :body_style
  belongs_to :size
  has_many :stocks, :dependent => :destroy
  has_many :garments, :through => :stocks
  has_many :inventory_snapshots, :through => :garments
  has_many :unit_prices
  has_many :products, :through => :body_style
  has_many :product_colors, :through => :products
  attr_accessible :size_id, :body_style_id, :weight, :price
  scope :ordered, order(:position)
  acts_as_list
  
  delegate :letter_code, :to => :size
  
  def name
    "#{size.andand.name} #{body_style.andand.name}"
  end
end
