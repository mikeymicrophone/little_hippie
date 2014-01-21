class SaleInclusion < ActiveRecord::Base
  belongs_to :sale
  belongs_to :inclusion, :polymorphic => true
  attr_accessible :sale_id, :active, :begin_date, :end_date, :inclusion_id, :inclusion_type
end
