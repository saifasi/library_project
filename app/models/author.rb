class Author < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :name, presence: true
  validates :bio, presence: true
end
