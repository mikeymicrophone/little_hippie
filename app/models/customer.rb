class Customer < ActiveRecord::Base
  has_many :carts
  has_many :charges, :through => :carts
  has_many :items, :through => :carts
  has_many :credit_cards
  has_many :shipping_addresses
  has_many :feedbacks
  has_many :wishlists
  has_many :wishlist_items, :through => :wishlists
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :phone_number
  # attr_accessible :title, :body
  
  def name
    if first_name.present? || last_name.present?
      "#{first_name} #{last_name}"
    else
      email
    end
  end
  
  def primary_wishlist
    wishlists.order('created_at').first || wishlists.create(:name => "#{name}'s wishlist")
  end
end
