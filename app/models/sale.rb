class Sale < ActiveRecord::Base
  attr_accessible :active, :amount, :begin_date, :end_date, :name, :percentage
  
  scope :current, lambda { where('(sales.begin_date is null or sales.begin_date < ?) and (sales.end_date is null or sales.end_date > ?)', Time.now, Time.now) }
  scope :active, lambda { where :active => true }
  scope :applicable, lambda { active.current }
end
