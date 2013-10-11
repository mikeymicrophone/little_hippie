class Color < ActiveRecord::Base
  has_many :product_colors, :dependent => :destroy
  has_many :products, :through => :product_colors, :uniq => true
  has_many :body_styles, :through => :products, :uniq => true
  has_many :designs, :through => :products, :uniq => true
  attr_accessible :code, :name, :css_hex_code, :canonical_color_names, :featured
  acts_as_list
  scope :featured, {:conditions => {:featured => true}}
  scope :ordered, {:order => 'colors.position'}
  scope :alphabetical, order(:name)
  scope :without_product, lambda { |product| select('colors.*').uniq.joins('left outer join product_colors on colors.id = product_colors.color_id left outer join products on product_colors.product_id = products.id').where('colors.id not in (select product_colors.color_id from product_colors where product_colors.product_id = ?)', product.id) }
  paginates_per 20
  
  define_index do
    indexes name
    indexes canonical_color_names
  end
  
  def random_product
    product_colors.first(:order => "random()")
  end
  
  def similar_color_products
    Color.search(name).map(&:product_colors).flatten
  end
end
