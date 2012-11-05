class Product < ActiveRecord::Base
  belongs_to :design
  belongs_to :body_style
  attr_accessible :design_id, :body_style_id, :price
  
  def name
    design.name + ' ' + body_style.name
  end
end
