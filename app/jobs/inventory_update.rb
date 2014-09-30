class InventoryUpdate
  def self.queue
    :mailer
  end
  
  def self.perform filename
    csv = CSV.open(File.join(Rails.root, 'tmp', 'current_inventory.csv'), 'wb')
    csv << [
      'Code',
      'Design',
      'BodyStyle',
      'Color',
      'Size',
      'Quantity'
    ]
    
    inventory = Nokogiri::XML(File.open(filename))
    inventory.xpath('//Product').each do |product_xml|
      full_og_code = product_xml.xpath('SKU').first.content
      puts full_og_code
      product_color_code = full_og_code[/\d+/]
      puts product_color_code
      product_color = ProductColor.find_by_og_code product_color_code
      next unless product_color
      full_og_code =~ /\-(.*)/
      size = Size.translation $1, product_color
      puts size
      quantity = product_xml.xpath('Quantity').first.content
      
      if size
        garment = product_color.garments.of_size(size.id).of_color(product_color.color_id).first
        if garment
          puts "updating inventory of #{garment.id} #{garment.name} to #{quantity}"
          garment.set_inventory quantity
        
          csv << [
            garment.product_color.og_code,
            garment.design.name,
            garment.body_style.name,
            garment.color.name,
            garment.size.name,
            quantity
          ]
        elsif garment = product_color.garments.first
          puts "updating inventory of #{garment.id} #{garment.name} to #{quantity}"
          garment.set_inventory quantity
          
          csv << [
            product_color_code,
            garment.design.name,
            garment.body_style.name,
            garment.color.name,
            garment.size.name,
            quantity
          ]
        else
          puts "garment not found: #{product_xml.xpath('ProductName').first.content}"
        end
      end
    end
    csv.close
    
    ReportMailer.inventory_report(ENV['INVENTORY_REPORT_RECIPIENT_EMAIL'], File.join(Rails.root, 'tmp', 'current_inventory.csv'))
  end
end
