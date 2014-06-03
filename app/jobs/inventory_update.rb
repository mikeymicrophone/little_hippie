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
      product_color_code = full_og_code[/\d+/]
      product_color = ProductColor.find_by_og_code product_color_code
      next unless product_color
      full_og_code =~ /\-(.*)/
      size = Size.translation $1, product_color
      quantity = product_xml.xpath('Quantity').first.content
      
      if size
        garment = product_color.garments.of_size(size.id).of_color(product_color.color_id).first
        if garment
          Rails.logger.info "updating inventory of #{garment.name} to #{quantity}"
          garment.set_inventory quantity
        
          csv << [
            garment.product_color.og_code,
            garment.design.name,
            garment.body_style.name,
            garment.color.name,
            garment.size.name,
            quantity
          ]
        else
          Rails.logger.info "garment not found: #{product_xml.xpath('ProductName').first.content}"
        end
      end
    end
    csv.close
    
    ReportMailer.inventory_report(ENV['INVENTORY_REPORT_RECIPIENT_EMAIL'], File.join(Rails.root, 'tmp', 'current_inventory.csv'))
  end
end
