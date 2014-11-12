class UnsignedUpUserMailer < ActionMailer::Base
  default from: ENV['mailgun_sender']

  def response(recipient)
    @name = recipient.from
    mail to: recipient.from[:email], subject: 'Signup Required!'
  end
end