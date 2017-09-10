class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  VALID_REGEX = /\A^[a-zA-Z0-9'!#$%&'*+\/=?^_ ,@()`{|}~.-]*$\z/
  validates :title, :text, presence: true, format: { with: VALID_REGEX }
  validates :title, length: { maximum: 80 }
  validates :text, length: { maximum: 500 }
end
