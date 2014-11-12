class UnsignedUpUserMailer < ActionMailer::Base
  default from: ENV['mailgun_sender']

  def response(recipient)
    @name = "there"
    puts "Name: #{recipient.from}"
    mail to: recipient.from[:email], subject: 'Signup Required!'
  end
end
