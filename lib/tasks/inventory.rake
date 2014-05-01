namespace :inventory do
  desc "create stock objects for each size and color combination available"
  task :stock_from_products => :environment do
    Product.all.each do |product|
      colors = product.colors
      body_style = product.body_style
      body_style_sizes = body_style.body_style_sizes
      body_style_sizes.each do |body_style_size|
        colors.each do |color|
          puts "#{body_style_size.name} in #{color.name}"
          Stock.find_or_create_by_body_style_size_id_and_color_id body_style_size.id, color.id
        end
      end
    end
  end
  
  desc "create garment objects for each design, size, and color combination available"
  task :garment_from_products => :stock_from_products do
    Product.all.each do |product|
      design = product.design
      product.stocks.each do |stock|
        puts "#{design.name} on #{stock.name}"
        Garment.find_or_create_by_design_id_and_stock_id design.id, stock.id
      end
    end
  end
  
  desc "create unit prices for each stock based on the body_style_size price"
  task :price_stocks => :stock_from_products do
    BodyStyleSize.all.each do |body_style_size|
      unit_price_for_size = body_style_size.unit_prices.size_only.last
      if unit_price_for_size
        body_style_size.stocks.each do |stock|
          puts "pricing #{stock.name} at #{unit_price_for_size.price}"
          UnitPrice.find_or_create_by_stock_id_and_price :stock_id => stock.id, :price => unit_price_for_size.price, :body_style_size_id => body_style_size.id
        end
      end
    end
  end
  
  desc "create unit prices for each garment based on the design price"
  task :price_garments => :garment_from_products do
    Design.all.each do |design|
      unit_price_for_design = design.unit_prices.design_only.last
      if unit_price_for_design
        design.garments.each do |garment|
          puts "pricing #{garment.name} at #{unit_price_for_design.price}"
          UnitPrice.find_or_create_by_garment_id_and_price :garment_id => garment.id, :price => unit_price_for_design.price, :design_id => design.id, :stock_id => garment.stock_id
        end
      end
    end
  end
  
  desc "determines current inventory levels for each garment and creates inventory_snapshot objects to record them"
  task :snapshot => :environment do
    Garment.all.each do |garment|
      existing_inventory = garment.inventory
      new_inventory = garment.received_inventories.without_snapshot
      new_inventory_total = new_inventory.inject(0) { |sum, inventory| sum + (inventory.delivery.quantity_delivered - inventory.amount_cancelled.to_i) }
      amount = 0
      if existing_inventory
        amount = new_inventory_total + existing_inventory.current_amount
      else
        amount = new_inventory_total
      end
      if amount > 0
        snapshot = InventorySnapshot.create :garment => garment, :initial_amount => amount, :current_amount => amount, :current => true
        if snapshot.valid?
          new_inventory.each { |i| i.update_attribute :first_snapshot, snapshot}
          existing_inventory.andand.update_attribute :current, :false
        end
      end
    end
  end
  
  desc "create snapshots from manual inventory"
  task :snapshot_manual => :environment do
    Inventory.all.each do |manual|
      size = manual.size
      design = manual.design
      color = manual.color
      body_style = manual.body_style
      
      if body_style && size
        body_style_size = BodyStyleSize.find_or_create_by_body_style_id_and_size_id body_style.id, size.id
        stock = body_style_size.stocks.find_or_create_by_color_id color.id
      
        garment = stock.garments.find_or_create_by_design_id design.id
        existing_inventory = garment.inventory
      
        snapshot = InventorySnapshot.new :garment => garment, :initial_amount => manual.amount, :current_amount => manual.amount, :current => true
      
        if existing_inventory
          # snapshot.initial_amount = snapshot.initial_amount + existing_inventory.current_amount
          # snapshot.current_amount = snapshot.current_amount + existing_inventory.current_amount
          existing_inventory.update_attribute :current, false
        end
      
        snapshot.save
      end
    end
  end
  
  desc "inputs Old Glory product codes where missing"
  task :ingest_og_codes => :environment do
    session = GoogleDrive.login(ENV['GOOGLE_DRIVE_USERNAME'], ENV['GOOGLE_DRIVE_PASSWORD'])

    stock_sheet = session.spreadsheet_by_key(ENV['GOOGLE_DRIVE_OLD_GLORY_SPREADSHEET_KEY']).worksheets[0]
    
    data_column_for = {'Old Glory code' => 1, 'Old Glory name' => 2, 'inventory' => 3, 'design name' => 4, 'body style code' => 5, 'design code' => 6, 'color name' => 7, 'product color id' => 11}
    column_for_comments = 10
    
    row = 1
    while stock_sheet[row, 1] != ''
      puts row
      if (design = Design.find_by_name stock_sheet[row, data_column_for['design name']]) && (body_style = BodyStyle.find_by_code stock_sheet[row, data_column_for['body style code']]) && (color = Color.find_by_name stock_sheet[row, data_column_for['color name']].downcase)
        product = Product.find_by_design_id_and_body_style_id design.id, body_style.id
        product_color = ProductColor.find_by_product_id_and_color_id product.andand.id, color.id
        if product_color
          if product_color.og_code.blank?
            product_color.update_attribute :og_code, stock_sheet[row, data_column_for['Old Glory code']].split('-').first
            stock_sheet[row, data_column_for['product color id']] = product_color.id
            puts "updated code for #{product_color.name}: #{product_color.og_code}"
          end
        else
          stock_sheet[row, column_for_comments] = 'This color is not found on LittleHippie.com'
        end
      else
        if not design
          stock_sheet[row, column_for_comments] = "Design name wrong"
        elsif not body_style
          stock_sheet[row, column_for_comments] = "Body Style code wrong"
        elsif not color
          stock_sheet[row, column_for_comments] = "Color name wrong"
        else
          stock_sheet[row, column_for_comments] = "Product Data Incomplete"
        end
      end
      stock_sheet.save
      row = row + 1
    end
    
  end
  
  desc "detect which products & colors are discontinued"
  task :establish_fixed_inventory => :environment do
    
  end
end
