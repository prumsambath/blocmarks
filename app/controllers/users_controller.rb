class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @bookmarks = @user.bookmarks
    @likes = @user.favorites

    # @hashtags = @bookmarks.hashtags # error
  end

  def update
    if current_user.update_attributes(user_params)
      flash[:notice] = 'User information successfully updated.'
    else
      flash[:error] = 'Invalid user information.'
    end
    redirect_to edit_user_registration_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :avatar)
  end
end
