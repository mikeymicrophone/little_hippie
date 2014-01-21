class SaleInclusion < ActiveRecord::Base
  belongs_to :sale
  attr_accessible :active, :begin_date, :end_date, :inclusion_id, :inclusion_type
end
