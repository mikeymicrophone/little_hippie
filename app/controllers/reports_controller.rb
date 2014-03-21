class ReportsController < ApplicationController
  def sales_dates
    if Date.today.month < 3
      @quarter_start = Date.civil(Date.today.year - 1, 9, 1)
      @quarter_end = Date.civil(Date.today.year - 1, 12, 31)
    elsif Date.today.month < 6
      @quarter_start = Date.civil(Date.today.year, 1, 1)
      @quarter_end = Date.civil(Date.today.year, 3, 31)
    elsif Date.today.month < 9
      @quarter_start = Date.civil(Date.today.year, 4, 1)
      @quarter_end = Date.civil(Date.today.year, 6, 30)
    else
      @quarter_start = Date.civil(Date.today.year, 7, 1)
      @quarter_end = Date.civil(Date.today.year, 9, 30)      
    end
  end
  
  def sales_report
    Resque.enqueue SalesReportGeneration, params[:start_date], params[:end_date], params[:email]
    redirect_to sales_report_dates_path, :notice => 'The report will be emailed shortly.'
  end
end
