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
end
