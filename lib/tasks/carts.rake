namespace :carts do
  desc 'Adds newly purchased carts to Old Glory Google spreadsheet'
  task :update_spreadsheet => :environment do
    session = GoogleDrive.login(ENV['GOOGLE_DRIVE_USERNAME'], ENV['GOOGLE_DRIVE_PASSWORD'])

    order_sheet = session.spreadsheet_by_key(ENV['GOOGLE_DRIVE_ORDER_SPREADSHEET_KEY']).worksheets[0]
    
    row = 1
    row_marker_text = "Don't delete or edit this - it is a marker for the order feed from littlehippie.com"
    while order_sheet[row, 1] != row_marker_text
      row = row + 1
    end

    order_detail_position_for = {"Charge Number" => 1, "Customer Order Date" => 2, "Order Submission Date" => 3,"Buyer Name" => 4,
      "Phone Number" => 5, "Buyer Email" => 6, "Ship To Address" => 7, "Ship To City" => 8, "Ship To State" => 9, "Ship To Zip Code" => 10, "Country" => 11,
      "Item Ordered" => 12, "Color" => 13, "Size" => 14, "LH Product Code" => 15, "Old Glory SKU Number" => 16, "Quantity" => 17,
      "Promo Code" => 18, "Promo Discount" => 19, "Item Sale Price" => 20, "Shipping Price" => 21, "Order Total" => 22,
      "Gift Note" => 23, "Ship Method" => 24, "Ship Date" => 25, "Tracking Number" => 26, "Shipment Notes" => 27}

    Charge.ready_for_old_glory.each do |charge|
      puts "handling charge #{charge.id}"
      cart = charge.cart
      shipping = cart.apparent_primary_shipping_address
      first_item_of_cart = true
      cart.items.each do |item|
        puts "item #{item.id}"
        begin
          if first_item_of_cart
            order_sheet[row, order_detail_position_for["Customer Order Date"]] = charge.created_at.strftime("%-m/%-d/%Y")
            order_sheet[row, order_detail_position_for["Order Submission Date"]] = Date.today.strftime("%-m/%-d/%Y")
            order_sheet[row, order_detail_position_for["Buyer Name"]] = shipping.full_name
            order_sheet[row, order_detail_position_for["Phone Number"]] = shipping.phone
            order_sheet[row, order_detail_position_for["Buyer Email"]] = shipping.email
            order_sheet[row, order_detail_position_for["Ship To Address"]] = shipping.street + ' ' + shipping.street2.to_s
            order_sheet[row, order_detail_position_for["Ship To City"]] = shipping.city
            order_sheet[row, order_detail_position_for["Ship To State"]] = shipping.state.andand.name
            order_sheet[row, order_detail_position_for["Ship To Zip Code"]] = shipping.zip
            order_sheet[row, order_detail_position_for["Country"]] = shipping.country.andand.name
            order_sheet[row, order_detail_position_for["Promo Code"]] = cart.coupon.andand.code
            order_sheet[row, order_detail_position_for["Promo Discount"]] = cart.coupon.andand.discount
            order_sheet[row, order_detail_position_for["Shipping Price"]] = cart.shipping_charge
            order_sheet[row, order_detail_position_for["Order Total"]] = cart.total
            order_sheet[row, order_detail_position_for["Ship Method"]] = cart.shipping_method_name
          end
          
          order_sheet[row, order_detail_position_for["Charge Number"]] = charge.id
          order_sheet[row, order_detail_position_for["Item Ordered"]] = item.product.name
          order_sheet[row, order_detail_position_for["Color"]] = item.color.name
          order_sheet[row, order_detail_position_for["Size"]] = item.size.code
          order_sheet[row, order_detail_position_for["LH Product Code"]] = item.product.code
          order_sheet[row, order_detail_position_for["Old Glory SKU Number"]] = item.product_color.og_code
          order_sheet[row, order_detail_position_for["Quantity"]] = item.quantity
          order_sheet[row, order_detail_position_for["Item Sale Price"]] = item.final_cost
          
          row = row + 1
          first_item_of_cart = false
        rescue StandardError => error
          puts error.inspect
        end
      end
      order_sheet.save
      charge.update_attribute :result, 'Old Glory notified'
    end
    order_sheet[row, 1] = row_marker_text
    order_sheet.save
  end
end
