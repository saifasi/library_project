class AuthorsController < ApplicationController
  def show
    @author = Author.find(params[:id])
    @books = author.books.order(published_date: :desc).page(params[:page]).per(10)
  end
end
