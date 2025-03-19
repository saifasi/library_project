class BooksController < ApplicationController
  def index
    @books = Book.all

    # Simple text search
    if params[:query].present?
      query_str = "%#{params[:query].downcase}%"
      @books = @books.where("LOWER(title) LIKE ?", query_str)
    end

    # Hierarchical search by Genre (using dropdown)
    if params[:genre_id].present?
      @books = @books.joins(:genres).where(genres: { id: params[:genre_id] })
    end

    @books = @books.order(published_date: :desc).page(params[:page]).per(10)
  end

  def show
    @book = Book.find(params[:id])
  end
end
