ThinkingSphinx::Index.define :product_color, :with => :active_record do
  indexes design.name
  indexes design.number
  indexes body_style.name, :as => :body_style
  indexes body_style.code
  indexes color.name, :as => :color
  indexes color.code, :as => :color_code
  indexes product.code, :as => :product_code, :sortable => true
end
