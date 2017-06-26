class ProductCSV
  def initialize
    @products = Product.active
  end

  def write_csv filename
    CSV.open(File.join(Rails.root, "tmp", filename), "wb") do |csv|
      csv << [
        "Title",
        "Body (HTML)",
        "Option1 Name",
        "Option1 Value",
        "Option2 Name",
        "Option2 Value",
        "Variant Inventory Tracker",
        "Variant Inventory Qty",
        "Variant Price"
      ]
      @products.each do |product|
        product.garments.each do |garment|
          list_garment garment, csv
        end
      end
    end
  end

  def list_garment garment, csv
    csv << [
      garment.product.name,
      garment.product.copy,
      "color",
      garment.color.name,
      "size",
      garment.size.name,
      "shopify",
      garment.inventory_amount,
      garment.product.size_price(garment.size)
    ]
  end
end
