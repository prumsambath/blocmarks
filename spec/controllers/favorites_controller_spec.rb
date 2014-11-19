require 'rails_helper'

RSpec.describe FavoritesController, :type => :controller do
  let(:bookmark) { create(:bookmark) }
  let(:user) { create(:user, email: 'john@example.com') }

  before :each do
    sign_in user
  end

  describe "POST #create" do
    it "adds a bookmark to the user's bookmark list" do
      post :create, bookmark_id: bookmark, id: nil
      expect(user.favorites.first.bookmark).to eq(bookmark)
    end

    it "redirects to bookmarks#index" do
      post :create, bookmark_id: bookmark, id: nil
      expect(response).to redirect_to(bookmarks_path)
    end
  end

  describe "DELETE #destroy" do
    before :each do
      user.favorites.create(bookmark: bookmark)
      controller.request.stub referer: user_path(user)
    end

    it "removes the bookmark from the user's bookmark list" do
      delete :destroy, bookmark_id: bookmark, id: bookmark.id
      expect(user.favorites.count).to eq(0)
    end

    it "redirects to users#show" do
      delete :destroy, bookmark_id: bookmark, id: bookmark.id
      expect(response).to redirect_to(user_path(user))
    end
  end
end
