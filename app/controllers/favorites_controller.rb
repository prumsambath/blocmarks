class FavoritesController < ApplicationController
  def create
    @bookmark = Bookmark.find(params[:bookmark_id])
    @liked = current_user.favorites.build(bookmark: @bookmark)
    if @liked.save
      flash[:notice] = "#{@bookmark.url} has been saved to your bookmark list."
    else
      flash[:error] = "There is an error adding to your bookmark list."
    end
    redirect_to bookmarks_path
  end

  def destroy
    @bookmark = Bookmark.find(params[:bookmark_id])
    liked = current_user.favorites.find(params[:id])
    if liked.destroy
      flash[:notice] = "#{@bookmark.url} has been removed to your bookmark list."
    else
      flash[:error] = "There is an error removing to your bookmark list."
    end
    redirect_to bookmarks_path
  end
end
