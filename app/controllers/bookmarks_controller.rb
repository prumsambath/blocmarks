class BookmarksController < ApplicationController
  def index
    @hashtags = Hashtag.all
    @bookmarks = Bookmark.includes(:hashtags).all
  end
end
