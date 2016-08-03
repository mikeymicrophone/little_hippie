ThinkingSphinx::Index.define :product_color, :with => :active_record do
  indexes design.name
  indexes design.number
  indexes body_style.name
  indexes body_style.code
  indexes color.name
  indexes color.code
  indexes product.code, :as => :product_code, :sortable => true
end
