class BookmarksController < ApplicationController

  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(permit_bookmark)
    @list = List.find(params[:list_id])
    @bookmark.list = @list
    # , list_id:  )
    if @bookmark.save
      redirect_to list_path(params[:list_id])
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
  end

  private

  def permit_bookmark
    params.require(:bookmark).permit(:comment, :movie_id, :list_id)
  end
end
