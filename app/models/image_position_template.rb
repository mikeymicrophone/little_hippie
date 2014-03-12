class ImagePositionTemplate < ActiveRecord::Base
  belongs_to :product_manager
  has_many :product_images, :dependent => :nullify
  attr_accessible :left, :name, :position, :scale, :top, :product_manager_id, :product_manager
  acts_as_list
  scope :ordered, order(:position)
  scope :last_used, joins(:product_images).order('product_images.created_at desc').limit(1)
  
  def display_name
    if name.present?
      name
    else
      "#{scale}% at #{top} x #{left}"
    end
  end
end
