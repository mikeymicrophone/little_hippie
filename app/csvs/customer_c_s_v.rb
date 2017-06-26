class CustomerCSV
  def initialize
    @customers = Customer.all
  end

  def write_csv filename
    CSV.open(File.join(Rails.root, "tmp", filename), "wb") do |csv|
      csv << [
        "First Name",
        "Last Name",
        "Email",
        "Company",
        "Address1",
        "Address2",
        "City",
        "Province",
        "Province Code",
        "Country",
        "Country Code",
        "Zip",
        "Phone",
        "Accepts Marketing",
        "Total Spent",
        "Total Orders",
        "Tags",
        "Note",
        "Tax Exempt"
      ]
      list_customers csv
    end
  end

  def list_customers csv
    claimed_carts = @customers.each { |customer| details_on customer, csv }
    
    @carts = Cart.complete.all - claimed_carts
    @carts.each do |cart|
      cart_details_on cart, csv
    end
  end

  def details_on customer, csv
    carts = (customer.carts.complete + ShippingAddress.where(:email => customer.email).map(&:cart)).uniq
    total_orders = carts.count
    total_spent = carts.inject(0) do |amount, cart|
      amount + cart.charges.last.andand.dollar_amount.to_f
    end
    
    last_cart = carts.last
    shipping_address = last_cart.andand.apparent_primary_shipping_address
    
    csv << [
      shipping_address.andand.first_name,
      shipping_address.andand.last_name,
      customer.email,
      shipping_address.andand.company,
      shipping_address.andand.street,
      shipping_address.andand.street2,
      shipping_address.andand.city,
      shipping_address.andand.state.andand.name,
      shipping_address.andand.state.andand.iso,
      shipping_address.andand.country.andand.name,
      shipping_address.andand.country.andand.iso,
      shipping_address.andand.zip,
      shipping_address.andand.phone,
      "yes",
      total_spent.to_s,
      total_orders.to_s,
      "",
      "",
      ""
    ]
    return carts
  end
  
  def cart_details_on cart, csv
    shipping_address = cart.andand.apparent_primary_shipping_address
    
    if shipping_address
      carts = ShippingAddress.where(:email => shipping_address.email).map(&:cart)
      total_orders = carts.count
      total_spent = carts.inject(0) do |amount, cart|
        amount + cart.charges.last.andand.dollar_amount.to_f
      end
    
      csv << [
        shipping_address.andand.first_name,
        shipping_address.andand.last_name,
        shipping_address.andand.email,
        shipping_address.andand.company,
        shipping_address.andand.street,
        shipping_address.andand.street2,
        shipping_address.andand.city,
        shipping_address.andand.state.andand.name,
        shipping_address.andand.state.andand.iso,
        shipping_address.andand.country.andand.name,
        shipping_address.andand.country.andand.iso,
        shipping_address.andand.zip,
        shipping_address.andand.phone,
        "yes",
        total_spent.to_s,
        total_orders.to_s,
        "",
        "",
        ""
      ]
    end
  end
end
