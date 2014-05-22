class InventoryCSV
  def initialize xml_file
    xml = File.open xml_file
    @xml = Nokogiri::XML xml
    xml.close
  end

  def write_csv filename
    CSV.open(File.join(Rails.root, "tmp", filename), "wb") do |csv|
      csv << [
        "Code",
        "Design",
        "BodyStyle",
        "Color",
        "Size",
        "Quantity"
      ]
      list_garments csv
    end
  end

  def list_garments csv
    @xml.xpath('//Product').each do |product_xml|
      full_og_code = product_xml.xpath('SKU').first.content
      product_color_code = full_og_code[/\d+/]
      product_color = ProductColor.find_by_og_code product_color_code
      next unless product_color
      full_og_code =~ /\-(.*)/
      size = size_translation $1
      quantity = product_xml.xpath('Quantity').first.content
      
      if size
        garment = product_color.garments.of_size(size.id).of_color(product_color.color_id).first
      else
        puts "Missing size: #{$1} for #{product_color.name}"
      end
      
      if garment
        specifications_for garment, quantity, csv
      else
        puts product_color.name
      end
    end
  end

  def specifications_for garment, quantity, csv
    csv << [
      garment.product_color.og_code,
      garment.design.name,
      garment.body_style.name,
      garment.color.name,
      garment.size.name,
      quantity
    ]
  end
  
  def size_translation code
    Size.find_by_name({
      '3' => 'newborn', '03' => 'newborn', '6' => '6 months', '06' => '6 months', '12' => '12 months', '18' => '18 months', '18m' => '18 months', '24' => '24 months', 'LG' => ["men's large", "women's large"], 'MD' => ["men's medium", "women's medium"], 'SM' => ["men's small", "women's small"], '2X' => "men's xx-large", '3X' => "men's xxx-large", 'XL' => ["men's x-large", "women's x-large"],
      'YXL' => '', 'YLG' => 'youth large', 'YMD' => 'youth medium', 'YSM' => 'youth small', '2T' => '2T', '3T' => '3T', '4T' => '4T', '5T' => '5/6', '5/6' => '5/6', 'J5/6' => '5/6', 'J7' => '7/8', '7T' => '7/8'
    }[code])
  end
end
