class Garment < ActiveRecord::Base
  belongs_to :stock
  belongs_to :design
  # attr_accessible :title, :body
end
