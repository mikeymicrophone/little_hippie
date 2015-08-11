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
    Garment.all.each do |garment|
      if garment.product.andand.active?
        if garment.stash!
          puts "just stashed #{garment.id}"
        end
      end
    end
    session = GoogleDrive.login(ENV['GOOGLE_DRIVE_USERNAME'], ENV['GOOGLE_DRIVE_PASSWORD'])

    discontinued_sheet = session.spreadsheet_by_key(ENV['GOOGLE_DRIVE_OLD_GLORY_DISCONTINUED_SPREADSHEET_KEY']).worksheets[2]
    
    data_column_for = {'Old Glory Code' => 1, 'Amount in Stock' => 3}
    
    size_translation = {'06' => '6 months', '12' => '12 months', '18' => '18 months', '24' => '24 months', 'LG' => ["men's large", "women's large"], 'MD' => ["men's medium", "women's medium"], 'SM' => ["men's small", "women's small"], '2X' => "men's xx-large", '3X' => "men's xxx-large", 'XL' => ["men's x-large", "women's x-large"],
      'YLG' => 'youth large', 'YMD' => 'youth medium', 'YSM' => 'youth small', '2T' => '2T', '4T' => '4T', '5T' => '5/6', '5/6' => '5/6', 'J5/6' => '5/6', 'J7' => '7/8', '7T' => '7/8'}
    
    row = 1
    while discontinued_sheet[row, 1] != ''
      puts row
      og_id = discontinued_sheet[row, data_column_for['Old Glory Code']]
      product_color_number = og_id[/(\d+)/]
      og_id =~ /\-([\w\d\/]+)/
      size_code = $1
      product_color = ProductColor.find_by_og_code product_color_number
      if product_color
        puts product_color.name
        product_color.garments.of_color(product_color.color_id).map(&:stashed_inventories).flatten.each &:destroy
        size = case size_translation[size_code]
        when Array
          (product_color.sizes & size_translation[size_code].map { |name| Size.find_by_name name }).first
        when String
          Size.find_by_name size_translation[size_code]
        end
        
        if size
          product_color.garments.of_size(size.id).of_color(product_color.color_id).each do |garment|
            puts garment.name
            inv = garment.set_inventory discontinued_sheet[row, data_column_for['Amount in Stock']]
            puts "inventory set to #{inv.current_amount} for #{size.name}"
          end
        else
          puts "size not found: #{size_code}"
        end
      else
        puts "product_color not found: #{product_color_number}"
        puts "OG name: #{discontinued_sheet[row, 2]}"
      end
      row = row + 1
    end
  end
  
  desc "update inventory with data in Old Glory XML"
  task :weekly_update, [:xml_filename] => [:environment] do
    size_translation = {
      '3' => 'newborn', '03' => 'newborn', '6' => '6 months', '06' => '6 months', '12' => '12 months', '18' => '18 months', '18m' => '18 months', '24' => '24 months', 'LG' => ["men's large", "women's large"], 'MD' => ["men's medium", "women's medium"], 'SM' => ["men's small", "women's small"], '2X' => "men's xx-large", '3X' => "men's xxx-large", 'XL' => ["men's x-large", "women's x-large"],
      'YXL' => '', 'YLG' => 'youth large', 'YMD' => 'youth medium', 'YSM' => 'youth small', '2T' => '2T', '3T' => '3T', '4T' => '4T', '5T' => '5/6', '5/6' => '5/6', 'J5/6' => '5/6', 'J7' => '7/8', '7T' => '7/8'
    }
    inventory = Nokogiri::XML(File.open(File.join(Rails.root, 'tmp', args[:xml_filename])))
    inventory.xpath('//Product').each do |product_xml|
      full_og_code = product_xml.xpath('SKU').first.content
      product_color_code = full_og_code[/\d+/]
      product_color = ProductColor.find_by_og_code product_color_code
      next unless product_color
      full_og_code =~ /\-(.*)/
      size = Size.find_by_name(size_translation[$1])
      quantity = product_xml.xpath('Quantity').first.content
      
      if size
        garment = product_color.garments.of_size(size.id).of_color(product_color.color_id).first
        puts "updating inventory of #{garment.name} to #{quantity}"
        garment.set_inventory quantity
      end
    end
  end
  
  desc "mark out-of-stock product_colors as unavailable and vice versa"
  task :mark_availability => :environment do
    ProductColor.find_each(:batch_size => 100) do |product_color|
      inventory_of_color = product_color.garments_of_this_color.inject(0) { |sum, garment| sum + garment.inventory_amount.to_i }
      if inventory_of_color > 0
        product_color.update_attribute :available, true
      else
        product_color.update_attribute :available, false
      end
    end
    
    Product.find_each(:batch_size => 100) do |product|
      if product.available_product_colors.length > 0
        product.update_attribute :available, true
      else
        product.update_attribute :available, false
      end
    end
  end
  
  desc "check if any products have a landing color which is out of stock"
  task :check_landing_colors => :mark_availability do
    Product.available.find_each(:batch_size => 100) do |product|
      begin
        unless product.landing_product_color.available
          puts product.id
          puts product.name
        end
      rescue
        puts "problem?:"
        puts product.id
      end
    end
  end
end
