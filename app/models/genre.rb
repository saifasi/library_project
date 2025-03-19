class Genre < ApplicationRecord
  has_many :books_genres, dependent: :destroy
  has_many :books, through: :books_genres

  validates :name, presence: true
end
