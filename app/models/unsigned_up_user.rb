class UnsignedUpUser < ActiveRecord::Base
  def send_email
    UnsignedUpUserMailer.response(self).deliver
  end
end
