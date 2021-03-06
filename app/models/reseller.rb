class Reseller < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :tax_id, :note, :url, :current_discount_percentage, :delivery_address_attributes, :delay_payment, :business_name, :sees_inventory, :authorized, :can_buy_blankets
  
  has_many :wholesale_orders
  belongs_to :delivery_address
  accepts_nested_attributes_for :delivery_address
  
  def has_credit_card?
    stripe_customer_id.present?
  end
end
