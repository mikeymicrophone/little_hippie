class BannerTag < ActiveRecord::Base
  belongs_to :banner
  belongs_to :tag, :polymorphic => true
  attr_accessible :active, :tag_id, :tag_type, :banner_id, :tag, :product_code
  validates_uniqueness_of :tag_id, :scope => [:banner_id, :tag_type]
  validates_presence_of :banner_id, :tag_id, :tag_type
  acts_as_list :scope => [:tag_type, :tag_id]
  attr_accessor :product_code
  
  before_validation :recognize_product_code
  after_create :bubble_up
  
  def name
    "#{tag.name} in #{banner.name}" rescue nil
  end
  
  def bubble_up
    case tag_type
    when 'Product'
      banner.banner_tags.create :tag => tag.body_style
      banner.banner_tags.create :tag => tag.design
    when 'ProductColor'
      banner.banner_tags.create :tag => tag.color
      banner.banner_tags.create :tag => tag.product
    when 'Garment'
      banner.banner_tags.create :tag => tag.product_color
      banner.banner_tags.create :tag => tag.size
    end
  end
  
  def recognize_product_code
    if product_code.present?
      self.tag = Product.find_by_code product_code
    end
  end
end
