require 'rails_helper'

describe EmailProcessor do
  before do
    @email = build(:email)
  end

  context "registered users" do
    before :each do
      create(:user)
    end

    describe "receives an incoming email" do
      context "email body has urls" do
        it "saves the url in the database" do
          expect {
            EmailProcessor.new(@email).process
          }.to change(Bookmark, :count).by(1)
        end

        it "save two urls in the database" do
          email = build(:email, body: "Bookmark http://example-link1.com http://example-link2.com")
          expect {
            EmailProcessor.new(email).process
          }.to change(Bookmark, :count).by(2)
        end
      end

      context "email body has no url" do
        it "does not save any url in the database" do
          email = build(:email, body: "No url presents.")
          expect {
            EmailProcessor.new(email).process
          }.to_not change(Bookmark, :count)
        end
      end

      context "with hashtags" do
        it "save hashtags in the database" do
          email = build(:email, subject: "Bookmark #new")
          expect {
            EmailProcessor.new(email).process
          }.to change(Hashtag, :count).by(1)
        end
      end

      context "without hashtags" do
        it "does not save any hashtags in the database" do
          email = build(:email, subject: "Bookmark")
          expect {
            EmailProcessor.new(email).process
          }.to_not change(Hashtag, :count)
        end
      end
    end
  end

  context "unregistered users" do
    describe "receives an incoming email" do
     it "does not save url in the database" do
        expect {
          EmailProcessor.new(@email).process
        }.to_not change(Bookmark, :count)
      end
    end
  end
end
