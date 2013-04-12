class Stock < ActiveRecord::Base
  belongs_to :body_style_size
  belongs_to :color
  # attr_accessible :title, :body
end
