json.order do
  json.id @charge.id
  json.date @charge.created_at
  
  json.customer do
    json.name @shipping_address.full_name
    json.phone @shipping_address.phone
    json.email @shipping_address.email
  end
  
  json.shipping_address do
    json.street(@shipping_address.street + ' ' + @shipping_address.street2.to_s)
    json.city @shipping_address.city
    json.state @shipping_address.state.andand.name
    json.zip @shipping_address.zip
    json.country @shipping_address.country.andand.name
  end

  json.payment do
    json.promo_code @cart.coupon.andand.code
    json.promo_discount @cart.coupon.andand.discount
    json.shipping_price @cart.shipping_charge
    json.total_price @cart.total
    json.shipping_method @cart.shipping_method_name  
  end
  
  json.items @cart.items do |item|
    json.name item.product.name
    json.color item.color.name
    json.size item.size.code
    json.lh_code item.product.code
    json.og_code item.product_color.og_code
    json.quantity item.quantity
    json.price item.final_cost
  end
end
