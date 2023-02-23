class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
    @movies = @list.movies
    @bookmarks = @list.bookmarks
  end

  def new
    @list = List.new
    redirect_to @list
  end

  def create
    @list = List.new(list_params)
    @movies = Movie.all

    if @list.save
      # Loop through the selected movie IDs and build a new bookmark for each one
      params[:list][:movie_ids].each do |movie_id|
        movie = Movie.find(movie_id)
        bookmark = Bookmark.new
        bookmark.list = @list
        bookmark.movie = movie
        puts bookmark.errors.full_messages
        bookmark.save
      end

      redirect_to @list
    else
      render :new
    end
  end

  def new_bookmark
    @list = List.find(params[:id])
    @bookmark = Bookmark.new
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
