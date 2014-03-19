class SalesReport
  attr_accessor :pdf
  
  def initialize start_date, end_date
    @pdf = Prawn::Document.new
    @start_date = start_date
    @end_date = end_date
    add_boilerplate
    list_product_sales
  end
  
  def add_boilerplate
    pdf.font('Helvetica', :style => :italic, :size => 20) { pdf.draw_text "http://littlehippie.com", :at => [280, 695] }
    # pdf.image File.join(Rails.root, ActionController::Base.helpers.asset_path('littlehippielogo.png')), :position => :left, :height => 70
    pdf.draw_text "Little Hippie", :at => [85, 700]
    pdf.draw_text @start_date.strftime("%m/%d/%y"), :at => [85, 680]
    pdf.draw_text @end_date.strftime("%m/%d/%y"), :at => [85, 660]
  end
  
  def list_product_sales
    Product.inventory_order.each { |product| sales_total_for_product product }
  end
  
  def sales_total_for_product product
    name = product.name
    purchases = product.items.purchased.since(@start_date).before(@end_date)
    quantity = purchases.sum :quantity
    gross = purchases.inject(0) { |sum, item| sum + item.final_price } / 100.0
    pdf.draw_text "#{quantity} x #{name} = #{gross}", :at => [product_line_start, current_product_line] unless quantity == 0
  end
  
  def render_printable_pdf filename
    pdf.render_file File.join(Rails.root, "tmp", filename)
  end
  
  def product_line_start
    85
  end
  
  def current_product_line
    @line_number ||= 0
    @line_number = @line_number + 1
    660 - 20 * @line_number
  end
end
