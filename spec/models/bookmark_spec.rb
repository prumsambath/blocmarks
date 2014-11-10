require 'rails_helper'

describe Bookmark do
  it "is valid with a link" do
    bookmark = Bookmark.new(link: "www.example.com")
    expect(bookmark).to be_valid
  end

  it "is invalid without a link"
  it "does not allow duplicate links per user"
  it "allows two users have the same bookmark link"
end
