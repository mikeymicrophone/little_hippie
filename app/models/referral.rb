class Referral < ActiveRecord::Base
  has_many :mailing_list_registrations
  attr_accessible :name, :position
  acts_as_list
  scope :ordered, order(:position)
end
