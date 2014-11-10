class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @bookmarks = @user.bookmarks

    # @hashtags = @bookmarks.hashtags # error
  end
end
