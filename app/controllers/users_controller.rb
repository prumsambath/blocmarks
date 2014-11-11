class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @likes = @user.favorites

    # @hashtags = @bookmarks.hashtags # error
  end
end
