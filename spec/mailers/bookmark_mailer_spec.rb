require "rails_helper"

RSpec.describe BookmarkMailer, :type => :mailer do
   describe '.receive' do
    before do
      @email =  {
        from:    "sender@example.com",
        to:      "recipient@example.com",
        subject: "Bookmark a URL",
        body:    "http://example.com"
      }
   end

    it "creates a new bookmark of url from the email body" do
      expect {
         BookmarkMailer.receive @email
      }.to change(Bookmark, :count).by(1)
    end

    it "does not save a bookmark if no url presents in the email body" do
      @email[:body] = ""

      expect {
         BookmarkMailer.receive @email
      }.to change(Bookmark, :count).by(0)  
    end

    it "saves a bookmark with hashtages" do
      @email[:subject] = "Bookmark a URL #testing"

      expect {
        BookmarkMailer.receive @email
        # expect(Bookmark.count).to eq(1)
        expect(Bookmark.hashtages.count).to eq(1)
      }
    end


  end
end
