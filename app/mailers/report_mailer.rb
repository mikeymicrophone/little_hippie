class ReportMailer < ActionMailer::Base
  def distribute email, filename
    attachments[filename] = File.read(File.join(Rails.root, 'tmp', filename))
    mail to: email, subject: 'Little Hippie Sales Report'
  end
end
