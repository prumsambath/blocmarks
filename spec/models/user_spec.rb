require 'rails_helper'

describe User do
  it { should have_many(:bookmarks).dependent(:destroy) }
  it { should have_many(:favorites).dependent(:destroy) }
  it { should validate_presence_of :name }

  describe "#liked" do
    it "returns the liked bookmark when user clicks like it" do
      bookmark = create(:bookmark)
      jane = create(:user, email: 'jane@example.com')

      jane.favorites.create(bookmark: bookmark)
      expect(jane.liked(bookmark).bookmark).to eq(bookmark)
    end
  end
end
