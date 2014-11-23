class BookmarksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @hashtags = Hashtag.all
    if params[:hashtag]
      @bookmarks = Bookmark.tagged_with(params[:hashtag])
    else
      @bookmarks = Bookmark.includes(:hashtags).all
    end
  end

  def show
    @bookmark = Bookmark.find(params[:id])
    # embedly_api = Embedly::API.new key: ENV['embedly_api_key'], :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; my@email.com)'
    # @preview_url = embedly_api.oembed(url: bookmark.url)
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.user_id = current_user.id

    if @bookmark.save
      respond_to do |format|
        message = "'#{@bookmark.url}' was successfully saved."
        format.html do
          flash[:notice] = message
          redirect_to current_user
        end
        format.js { flash.now[:notice] = message }
      end
    else
      flash[:error] = "Error saving bookmark. Please try again."
      redirect_to current_user
    end
  end

  def destroy
    @user_bookmark = current_user.bookmarks.find(params[:id])

    @user_bookmark.destroy
    respond_to do |format|
      message = "Bookmark was successfully deleted."

      format.html do
        flash[:notice] = message
        redirect_to current_user
      end
      format.js { flash.now[:notice] = message }
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:url, :all_hashtags)
  end
end
