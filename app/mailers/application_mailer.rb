class ApplicationMailer < ActionMailer::Base
  default :from => 'HSSB公式 <hssb.official@gmail.com>',
          :bcc => "sample+sent@gmail.com",
          :reply_to => "sample+reply@gmail.com"
  layout 'mailer'
end
