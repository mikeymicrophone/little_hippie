class SalesReport
  attr_accessor :pdf
  
  def initialize start_date, end_date
    @pdf = Prawn::Document.new
    @start_date = start_date
    @end_date = end_date
    add_boilerplate
  end
  
  def add_boilerplate
    pdf.font('Helvetica', :style => :italic, :size => 20) { pdf.draw_text "http://littlehippie.com", :at => [280, 695] }
    # pdf.image File.join(Rails.root, ActionController::Base.helpers.asset_path('littlehippielogo.png')), :position => :left, :height => 70
    pdf.draw_text "Little Hippie", :at => [85, 700]
    pdf.draw_text @start_date.strftime("%m/%d/%y"), :at => [85, 680]
    pdf.draw_text @end_date.strftime("%m/%d/%y"), :at => [85, 660]
  end
  
  def render_printable_pdf filename
    pdf.render_file File.join(Rails.root, "tmp", filename)
  end
end
