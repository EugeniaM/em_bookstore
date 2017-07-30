class Book < ApplicationRecord
  belongs_to :category
  has_many :book_authors, dependent: :destroy 
  has_many :authors, through: :book_authors
  accepts_nested_attributes_for :book_authors, allow_destroy: true
  mount_uploaders :covers, CoverUploader

  validates :title, :short_description, :full_description, :price, :category_id, presence: true
end
