class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.find(params[:id])
  end

  def index
    @hashtags = Hashtag.all
  end
end
