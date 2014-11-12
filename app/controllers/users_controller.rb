class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @bookmarks = @user.bookmarks
    @likes = @user.favorites

    # @hashtags = @bookmarks.hashtags # error
  end
end
