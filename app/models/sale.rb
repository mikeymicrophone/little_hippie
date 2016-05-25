class Sale < ActiveRecord::Base
  has_many :sale_inclusions
  attr_accessible :active, :amount, :begin_date, :end_date, :name, :percentage
  
  scope :current, lambda { where('(sales.begin_date is null or sales.begin_date < ?) and (sales.end_date is null or sales.end_date > ?)', Time.now, Time.now) }
  scope :active, lambda { where :active => true }
  scope :applicable, lambda { active.current }
  scope :recent, order('created_at desc')
end
