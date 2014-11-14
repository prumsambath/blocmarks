require 'rails_helper'

describe Bookmark do
  it "has a valid factory" do
    expect(build(:bookmark)).to be_valid
  end

  it { should validate_presence_of :url }
  it { should belong_to(:user) }

  it "does not allow duplicate links per user" do
    bookmark = create(:bookmark)
    user = bookmark.user

    another_bookmark = user.bookmarks.build(url: bookmark.url)
    another_bookmark.valid?
    expect(another_bookmark.errors[:url]).to include("has already been taken")
  end

  it "allows two users have the same bookmark link" do
    bookmark = create(:bookmark)
    john = create(:user, email: 'john@example.com')
    john.bookmarks.create(url: bookmark.url)

    jane = create(:user, email: 'jane@example.com')
    jane_bookmark = jane.bookmarks.build(url: bookmark.url)
    expect(jane_bookmark).to be_valid
  end
end
