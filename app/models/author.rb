class Author < ApplicationRecord
  # has_and_belongs_to_many :books
  has_many :book_authors
  has_many :books, through: :book_authors
  accepts_nested_attributes_for :book_authors, allow_destroy: true

  VALID_NAMES_REGEX = /\A[a-zA-Z .]+\z/
  validates :first_name, :last_name, :description, presence: true
  validates :first_name, :last_name, format: { with: VALID_NAMES_REGEX }, length: { maximum: 50 }

  def to_s
    "#{self.first_name} #{self.last_name}"
  end
end
