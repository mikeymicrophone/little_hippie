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
      existing_inventory = garment.inventory_snapshots.last
      new_inventory = garment.received_inventories.without_snapshot
      new_inventory_total = new_inventory.inject(0) { |sum, inventory| sum + (inventory.delivery.quantity_delivered - inventory.amount_cancelled.to_i) }
      amount = 0
      if existing_inventory
        amount = new_inventory_total + existing_inventory.current_amount
      else
        amount = new_inventory_total
      end
      snapshot = InventorySnapshot.create :garment => garment, :initial_amount => amount, :current_amount => amount, :current => true
      if snapshot.valid?
        new_inventory.each { |i| i.update_attribute :first_snapshot, snapshot}
        existing_inventory.update_attribute :current, :false
      end
    end
  end
end
