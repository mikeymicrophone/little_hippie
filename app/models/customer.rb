class Customer < ActiveRecord::Base
  has_many :carts
  has_many :charges, :through => :carts
  has_many :items, :through => :carts
  has_many :credit_cards
  has_many :shipping_addresses
  has_many :feedbacks
  has_many :wishlists
  has_many :wishlist_items, :through => :wishlists
  has_many :friend_emails
  has_many :likes
  has_many :liked_products, :through => :likes, :source => :product
  has_many :liked_designs, :through => :likes, :source => :design
  has_many :liked_banners, :through => :likes, :source => :banner
  has_many :liked_bulletins, :through => :likes, :source => :bulletin
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :phone_number, :facebook_id
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
  
  def liked_product_ids
    liked_products.map &:id
  end
  
  def liked_design_ids
    liked_designs.map &:id
  end
  
  def liked_banner_ids
    liked_banners.map &:id
  end
  
  def liked_bulletin_ids
    liked_bulletins.map &:id
  end
  
  def referral_types
    carts.map(&:referral_type).uniq.compact.join(', ')
  end
  
  def password_required?
    super unless facebook_id.present?
  end
end
