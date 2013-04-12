class UnitPrice < ActiveRecord::Base
  belongs_to :stock
  belongs_to :garment
  # attr_accessible :title, :body
end
