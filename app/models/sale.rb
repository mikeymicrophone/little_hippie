class Sale < ActiveRecord::Base
  attr_accessible :active, :amount, :begin_date, :end_date, :name, :percentage
  
  scope :current, lambda { where('(begin_date is null or begin_date < ?) and (end_date is null or end_date > ?)', Time.now, Time.now) }
  scope :active, lambda { where :active => true }
end
