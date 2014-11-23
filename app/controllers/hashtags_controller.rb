class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.includes(:bookmarks).find(params[:id])
  end

  def index
    @hashtags = Hashtag.all
  end
end
