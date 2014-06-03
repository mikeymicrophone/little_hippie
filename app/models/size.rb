class Size < ActiveRecord::Base
  has_many :inventories
  has_many :body_style_sizes
  has_many :body_styles, :through => :body_style_sizes
  has_many :products, :through => :body_styles
  has_many :designs, :through => :products, :uniq => true
  has_many :banner_tags, :as => :tag
  attr_accessible :code, :name
  acts_as_list
  scope :ordered, {:order => 'sizes.position'}
  
  def self.xxl
    find_by_name "men's xx-large"
  end
  
  def self.xxxl
    find_by_name "men's xxx-large"
  end
  
  def self.translation code, product_color
    size_name = {
      '3' => 'newborn', '03' => 'newborn', '6' => '6 months', '06' => '6 months', '12' => '12 months', '18' => '18 months', '18m' => '18 months', '24' => '24 months', 'LG' => ["men's large", "women's large"], 'MD' => ["men's medium", "women's medium"], 'SM' => ["men's small", "women's small"], '2X' => "men's xx-large", '3X' => "men's xxx-large", 'XL' => ["men's x-large", "women's x-large"],
      'YXL' => '', 'YLG' => 'youth large', 'YMD' => 'youth medium', 'YSM' => 'youth small', '2T' => '2T', '3T' => '3T', '4T' => '4T', '5T' => '5/6', '5/6' => '5/6', 'J5/6' => '5/6', 'J7' => '7/8', '7T' => '7/8'
    }[code]
    sizes = find_all_by_name(size_name)
    if sizes.length == 1
      sizes.first
    else
      product_color.sizes.select { |s| sizes.include? s }.first
    end
  end
end
