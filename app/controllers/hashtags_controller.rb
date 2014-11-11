class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.find(params[:id])
  end
end
