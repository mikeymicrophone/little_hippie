ThinkingSphinx::Index.define :product, :with => :active_record do
  indexes design.name, :as => :design_name
  indexes design.number, :as => :design_number
  indexes body_style.name, :as => :body_style
  indexes body_style.code, :as => :body_style_code
  indexes code
end
