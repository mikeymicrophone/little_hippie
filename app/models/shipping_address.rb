class ShippingAddress < ActiveRecord::Base
  belongs_to :customer
  belongs_to :cart
  attr_accessible :city, :country, :email, :first_name, :last_name, :phone, :position, :state, :street, :street2, :zip, :customer_id, :cart_id
  acts_as_list :scope => :customer_id
  
  def display
    %Q{
      <div class="shipping_address">
      #{first_name} #{last_name}<br>
      #{street}<br>
      #{street2}<br>
      #{city}, #{state}<br>
      #{zip}<br>
      #{country}
      </div>
    }.html_safe
  end
end
