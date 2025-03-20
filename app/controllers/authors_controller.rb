class AuthorsController < ApplicationController
  def show
    @current_author = Author.find(params[:id])
    @books = @current_author.books.order(:published_date).page(params[:page]).per(10)
  end
end
