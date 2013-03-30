class Color < ActiveRecord::Base
  has_many :product_colors, :dependent => :destroy
  has_many :products, :through => :product_colors, :uniq => true
  has_many :body_styles, :through => :products, :uniq => true
  has_many :designs, :through => :products, :uniq => true
  attr_accessible :code, :name, :css_hex_code
  acts_as_list
  scope :ordered, {:order => 'colors.position'}
  scope :alphabetical, order(:name)
  scope :without_product, lambda { |product| select('colors.*').uniq.joins(:products).where('colors.id not in (select product_colors.color_id from product_colors where product_colors.product_id = ?)', product.id) }
  paginates_per 20
end
