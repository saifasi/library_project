class Book < ApplicationRecord
  belongs_to :author
  has_many :books_genres, dependent: :destroy
  has_many :genres, through: :books_genres

  has_many :books_tags, dependent: :destroy
  has_many :tags, through: :books_tags

  validates :title, presence: true
  validates :description, presence: true
end
