class SalesReportGeneration
  def self.queue
    :mailer
  end
  
  def self.perform start_date, end_date, email
    @start_date = Date.civil start_date['year'].to_i, start_date['month'].to_i, start_date['day'].to_i
    @end_date = Date.civil end_date['year'].to_i, end_date['month'].to_i, end_date['day'].to_i
    filename = "Little Hippie Sales Report #{@start_date.strftime("%m-%d-%y")} - #{@end_date.strftime("%m-%d-%y")}.csv"
    sales_report = SalesReportCSV.new @start_date, @end_date
    sales_report.write_csv filename
    ReportMailer.distribute(email, filename).deliver
  end
end
