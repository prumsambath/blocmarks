require 'rails_helper'

describe IncomingMailsController do
  context 'POST #create' do
    before do
      @parameters = {
        from:    "sender@example.com",
        to:      "recipient@example.com",
        subject: "Bookmark a URL",
        body:    "http://example.com"
      }
    end

    it "creates with an invalid item" do
      before do
        expect(Bookmark.any_instance.valid?).to eq(false)
        post :create, email: @email
      end

      expect(response).to have_http_status(422)
    end

    it "creates with a valid item" do
      before do
        expect(Bookmark.any_instance.valid?).to eq(true)
        post :create, email: @email
      end

      expect(response).to have_http_status(201)
    end
  end
end
