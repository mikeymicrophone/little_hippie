class SalesReportCSV
  
  def initialize start_date, end_date
    @start_date = start_date
    @end_date = end_date
  end
  
  def write_csv filename
    CSV.open(File.join(Rails.root, "tmp", filename), "wb") do |csv|
      csv << [
        "Product Code",
        "Design",
        "Style",
        "Units Sold",
        "Mark Up",
        "Royalty %",
        "Return $",
        "Discount $",
        "Total Sale",
        "Royalty Due"
      ]
      list_product_sales csv
    end
  end
  
  def list_product_sales csv
    Product.inventory_order.each { |product| sales_total_for_product product, csv }
  end
  
  def sales_total_for_product product, csv
    name = product.name
    purchases = product.items.purchased.since(@start_date).before(@end_date)
    quantity = purchases.sum :quantity
    gross = purchases.inject(0) { |sum, item| sum + item.net_profit } / 100.0
    if quantity > 0
      csv << [
        product.code,
        product.design.name,
        product.body_style.name,
        quantity,
        ActionController::Base.helpers.number_to_currency(product.profit / 100.0),
        '10.00%',
        '',
        '',
        ActionController::Base.helpers.number_to_currency(gross),
        ActionController::Base.helpers.number_to_currency(gross / 10.0)
      ]
    end
  end
  
end
