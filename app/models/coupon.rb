class Coupon < ActiveRecord::Base
  attr_accessible :amount, :code, :expiration_date, :lower_limit, :name, :percentage, :upper_limit, :valid_date
end
