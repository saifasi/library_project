class Tag < ApplicationRecord
  has_many :books_tags, dependent: :destroy
  has_many :books, through: :books_tags

  validates :name, presence: true
end
