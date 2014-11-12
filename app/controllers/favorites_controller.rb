class FavoritesController < ApplicationController
  def create
    get_bookmark
    @liked = current_user.favorites.build(bookmark: @bookmark)

    if @liked.save
      respond_to do |format|
        message = "#{@bookmark.url} has been saved to your bookmark list."

        format.html do
          flash[:notice] = message
          redirect_to bookmarks_path
        end

        format.js do
          flash.now[:notice] = message
          render action: 'show_favorite_button'
        end
      end
    end
  end

  def destroy
    get_bookmark
    liked = current_user.favorites.find(params[:id])

    liked.destroy
    respond_to do |format|
      message =  "#{@bookmark.url} has been removed from your bookmark list."

      format.html do
        flash[:notice] = message
        redirect_to request.referer
      end

      format.js do
        flash.now[:notice] = message
        render action: 'show_favorite_button'
      end
    end
  end

  private

  def get_bookmark
    @bookmark = Bookmark.find(params[:bookmark_id])
  end
end
