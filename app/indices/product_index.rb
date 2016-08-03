ThinkingSphinx::Index.define :product, :with => :active_record do
  indexes design.name
  indexes design.number
  indexes body_style.name
  indexes body_style.code
  indexes code
end
