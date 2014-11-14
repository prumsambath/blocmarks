class UnsignedUpUserMailer < ActionMailer::Base
  default from: ENV['mailgun_sender']

  def response(user)
    @name = user.name
    mail to: user.email, subject: 'Sign-up Required!'
  end
end
