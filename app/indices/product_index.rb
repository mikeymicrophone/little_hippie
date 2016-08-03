ThinkingSphinx::Index.define :product, :with => :active_record do
  indexes design.name
  indexes design.number
  indexes body_style.name, :as => :body_style
  indexes body_style.code, :as => :body_style_code
  indexes code
end
