class ImagePositionTemplate < ActiveRecord::Base
  belongs_to :product_manager
  has_many :product_images
  attr_accessible :left, :name, :position, :scale, :top, :product_manager_id, :product_manager
  acts_as_list
  scope :ordered, order(:position)
  
  def display_name
    if name.present?
      name
    else
      "#{scale}% at #{top} x #{left}"
    end
  end
end
