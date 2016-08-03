ThinkingSphinx::Index.define :charge, :with => :active_record do
  indexes id
  indexes customer_name
end
