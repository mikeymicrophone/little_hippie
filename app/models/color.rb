class Color < ActiveRecord::Base
  has_many :product_colors, :dependent => :destroy
  has_many :products, :through => :product_colors, :uniq => true
  has_many :body_styles, :through => :products, :uniq => true
  has_many :designs, :through => :products, :uniq => true
  has_many :sale_inclusions, :as => :inclusion
  has_many :banner_tags, :as => :tag
  has_many :stocks
  has_many :garments, :through => :stocks
  attr_accessible :code, :name, :css_hex_code, :canonical_color_names, :featured
  acts_as_list
  scope :featured, {:conditions => {:featured => true}}
  scope :ordered, {:order => 'colors.position'}
  scope :available, {:joins => :product_colors}
  scope :alphabetical, order(:name)
  scope :without_product, lambda { |product| select('colors.*').uniq.joins('left outer join product_colors on colors.id = product_colors.color_id left outer join products on product_colors.product_id = products.id').where('colors.id not in (select product_colors.color_id from product_colors where product_colors.product_id = ?)', product.id) }
  paginates_per 20
  
  ThinkingSphinx::Index.define :color, :with => :active_record do
    indexes name
    indexes canonical_color_names
  end
  
  def is_on_sale?
    sale_inclusions.applicable.first
  end
  
  def random_product
    product_colors.active_product.available.first(:order => "random()")
  end
  
  def similar_color_products
    Color.search(name).map(&:product_colors).flatten
  end
  
  def next_featured_color
    return nil unless next_color = lower_item
    until (next_color.featured? && next_color.random_product.present?)
      return nil unless next_color = next_color.lower_item
    end
    next_color
  end
  
  def previous_featured_color
    return nil unless previous_color = higher_item
    until (previous_color.featured? && previous_color.random_product.present?)
      return nil unless previous_color = previous_color.higher_item
    end
    previous_color
  end
  
  def to_param
    "#{id}-#{name.gsub(/[\s\/]/, '')}"
  end
end
