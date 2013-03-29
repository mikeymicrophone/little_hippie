class Feedback < ActiveRecord::Base
  belongs_to :customer
  attr_accessible :ip, :message, :needs_reply, :read, :refund, :starred, :testimonial, :customer_id
end
