class BookmarksController < ApplicationController
  def index
    @hashtags = Hashtag.includes(:bookmarks).all
  end
end
