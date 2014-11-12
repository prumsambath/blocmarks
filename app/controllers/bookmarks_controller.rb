class BookmarksController < ApplicationController
  def index
    @hashtags = Hashtag.all
    @bookmarks = Bookmark.includes(:hashtags).all
  end

  def show
    bookmark = Bookmark.find(params[:id])
    embedly_api = Embedly::API.new key: ENV['embedly_api_key'], :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; my@email.com)'
    @preview_url = embedly_api.oembed(url: bookmark.url)
  end

  def new
    @bookmark = Bookmark.new
  end

  def create
    bookmark = Bookmark.new(bookmark_params)
    user_bookmark = current_user.bookmarks.build(url: bookmark.url)
    # TODO add a hashtag to the new bookmark
    user_bookmark.hashtags.build(text: 'default')

    if user_bookmark.save
      flash[:notice] = "Bookmark was successfully saved."
      redirect_to current_user
    else
      flash[:error] = "Error saving bookmark. Please try again."
      render :new
    end
  end

  def destroy
    user_bookmark = current_user.bookmarks.find(params[:id])

    if user_bookmark.destroy
      flash[:notice] = "Bookmark was successfully deleted."
    else
      flash[:error] = "Error deleting bookmark. Please try again."
    end
    redirect_to current_user
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:url)
  end
end
