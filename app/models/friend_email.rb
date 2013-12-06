class FriendEmail < ActiveRecord::Base
  belongs_to :product
  belongs_to :color
  belongs_to :size
  belongs_to :customer
  attr_accessible :email, :message, :product, :product_id, :color, :color_id, :size, :size_id, :customer, :customer_id
  
  after_create :send_as_email
  
  def send_as_email
    FriendMailer.product_suggestion(id).deliver
  end
end
