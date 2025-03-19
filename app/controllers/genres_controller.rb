class GenresController < ApplicationController
  def index
    @genres = Genre.order(:name)
  end

  def show
    @genre = Genre.find(params[:id])
    @books = @genre.books.order(published_date: :desc).page(params[:page]).per(10)
  end
end
