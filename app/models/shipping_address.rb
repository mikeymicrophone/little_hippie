class ShippingAddress < ActiveRecord::Base
  belongs_to :customer
  belongs_to :cart
  belongs_to :state
  belongs_to :country
  attr_accessible :city, :country, :email, :first_name, :last_name, :phone, :position, :street, :street2, :zip, :customer_id, :cart_id, :company, :state_id, :country_id
  acts_as_list :scope => :customer_id
  
  def display
    %Q{
      <div class="shipping_address">
      #{first_name} #{last_name}<br>
      #{street}<br>
      #{street2}<br>
      #{city}, #{state.name}<br>
      #{zip}<br>
      #{country.name}
      </div>
    }.html_safe
  end
  
  def plain_text_display
    %Q{
      #{first_name} #{last_name}
      #{street}
      #{street2}
      #{city}, #{state.name}
      #{zip}
      #{country.name}
    }
  end
end
