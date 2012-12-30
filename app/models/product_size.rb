class ProductSize < ActiveRecord::Base
  belongs_to :product
  belongs_to :size
  attr_accessible :product_id, :size_id, :size
end
