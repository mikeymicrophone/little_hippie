class InventoryUpdate
  def self.queue
    :mailer
  end
  
  def self.perform inventory_list_id
    # csv = CSV.open(File.join(Rails.root, 'tmp', 'current_inventory.csv'), 'wb')
    # csv << [
    #   'Code',
    #   'Design',
    #   'BodyStyle',
    #   'Color',
    #   'Size',
    #   'Quantity'
    # ]
    
    inventory = Nokogiri::XML(open(InventoryList.find(inventory_list_id).xml_file.to_s))
    inventory.xpath('//Product').each do |product_xml|
      full_og_code = product_xml.xpath('SKU').first.content
      puts full_og_code
      product_color_code = full_og_code[/\d+/]
      puts product_color_code
      product_color = ProductColor.find_by :og_code =>  product_color_code
      next unless product_color
      full_og_code =~ /\-(.*)/
      size = Size.translation $1, product_color
      # puts size.name
      quantity = product_xml.xpath('Quantity').first.content
      
      if size
        garment = product_color.garments.of_size(size.id).of_color(product_color.color_id).first
        if garment
          puts "updating inventory of #{garment.id} #{garment.name} to #{quantity}"
          garment.set_inventory quantity.to_i
        
          # csv << [
          #   garment.product_color.og_code,
          #   garment.design.name,
          #   garment.body_style.name,
          #   garment.color.name,
          #   garment.size.name,
          #   quantity
          # ]
        elsif garment = product_color.garments.first
          puts "updating inventory of #{garment.id} #{garment.name} to #{quantity}"
          garment.set_inventory quantity.to_i
        end
      elsif garment = product_color.garments.first
        puts "updating inventory of #{garment.id} #{garment.name} to #{quantity}"
        garment.set_inventory quantity.to_i
        
        # csv << [
        #   product_color_code,
        #   garment.design.name,
        #   garment.body_style.name,
        #   garment.color.name,
        #   garment.size.name,
        #   quantity
        # ]
      else
        puts "garment not found: #{product_xml.xpath('ProductName').first.content}"
      end
    end
    # csv.close
    
    # ReportMailer.inventory_report(ENV['INVENTORY_REPORT_RECIPIENT_EMAIL'], File.join(Rails.root, 'tmp', 'current_inventory.csv'))
  end
end
