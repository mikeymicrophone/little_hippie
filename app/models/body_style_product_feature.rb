class BodyStyleProductFeature < ActiveRecord::Base
  belongs_to :body_style
  belongs_to :product_color
  has_one :product, :through => :product_color
  has_one :color, :through => :product_color
  attr_accessible :position, :body_style_id, :product_color_id
  
  scope :by_body_style, order(:body_style_id).order(:position)
  scope :ordered, order(:position)
  
  acts_as_list :scope => :body_style_id
  
  def name
    "Featured #{position.ordinalize} in #{body_style.name}"
  end
end
