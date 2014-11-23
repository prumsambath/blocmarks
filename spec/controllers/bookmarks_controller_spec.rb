require 'rails_helper'

describe BookmarksController do
  let(:user) { create(:user) }

  shared_examples 'public access to bookmarks' do
    describe 'GET #index' do
      it "populates an array of all bookmarks" do
        news_bookmark = create(:bookmark, url: "http://news.example.com", user: user)
        blog_bookmark = create(:bookmark, url: "http://blog.example.com", user: user)
        get :index
        expect(assigns(:bookmarks)).to match_array([news_bookmark, blog_bookmark])
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template(:index)
      end
    end

    describe 'GET #show' do
      it "assigns the requested bookmark to @bookmark" do
        bookmark = create(:bookmark, user: user)
        get :show, id: bookmark
        expect(assigns(:bookmark)).to eq(bookmark)
      end

      it "renders the :show template" do
        bookmark = create(:bookmark, user: user)
        get :show, id: bookmark
        expect(response).to render_template(:show)
      end
    end
  end

  shared_examples 'full access to bookmarks' do
    describe 'POST #create' do
      context "with valid attributes" do
        it "saves the new bookmark in the database" do
          expect {
            post :create, bookmark: attributes_for(:bookmark)
          }.to change(Bookmark, :count).by(1)
        end

        it "redirects to users#show" do
          post :create, bookmark: attributes_for(:bookmark)
          expect(response).to redirect_to(user_path(user))
        end
      end

      context "without valid attributes" do
        it "does not save the new bookmark" do
          expect {
            post :create, bookmark: attributes_for(:invalid_bookmark)
          }.to_not change(Bookmark, :count)
        end
      end
    end

    describe "DELETE #destroy" do
      before :each do
        @bookmark = create(:bookmark, user: user)
      end

      it "deletes the contact" do
        expect {
          delete :destroy, id: @bookmark
        }.to change(Bookmark, :count).by(-1)
      end

      it "redirects to users#show" do
        delete :destroy, id: @bookmark
        expect(response).to redirect_to(user_path(user))
      end
    end
  end

  describe "user access to bookmarks" do
    before :each do
      set_user_session(user)
      allow(request.env['warden']).to receive(:authenticate!) { user }
      allow(controller).to receive(:current_user) { user }
    end

    it_behaves_like "public access to bookmarks"
    it_behaves_like "full access to bookmarks"
  end

  describe "guest access to bookmarks" do
    before :each do
      request.env['warden'].stub(:authenticate!).
        and_throw(:warden, { scope: :user} )
    end

    it_behaves_like "public access to bookmarks"

    describe "POST #create" do
      it "requires login" do
        post :create, id: create(:bookmark), bookmark: attributes_for(:bookmark)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "DELETE #destroy" do
      it "requires login" do
        delete :destroy, id: create(:bookmark)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
