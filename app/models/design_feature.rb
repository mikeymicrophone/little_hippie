class DesignFeature < ActiveRecord::Base
  belongs_to :design
  belongs_to :business_manager
  attr_accessible :active_from, :active_until, :business_manager_id, :position, :design_id
  acts_as_list
  scope :ordered, order(:position)
  scope :has_begun, lambda { where('active_from is null or active_from < ?', Time.now) }
  scope :not_ended, lambda { where('active_until is null or active_until > ?', Time.now) }
  scope :current, lambda { has_begun.not_ended }
end
