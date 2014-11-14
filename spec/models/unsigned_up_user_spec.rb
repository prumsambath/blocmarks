require 'rails_helper'

describe UnsignedUpUser do
  describe "sends email to notify sign-up" do
    let(:user) { create(:unsigned_up_user) }

    it "delivers email to user" do
      user.send_email
      expect(last_email.to).to include(user.email)
    end
  end
end
