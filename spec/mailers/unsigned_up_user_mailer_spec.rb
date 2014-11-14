require "rails_helper"

describe UnsignedUpUserMailer do
  describe ".response" do
    let(:user) { create(:unsigned_up_user) }
    let(:mail) { UnsignedUpUserMailer.response(user) }

    it "sends notified email for sign-up" do
      expect(mail.subject).to eq("Sign-up Required!")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq([ENV['mailgun_sender']])
    end
  end
end
