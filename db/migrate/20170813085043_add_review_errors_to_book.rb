class AddReviewErrorsToBook < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :review_errors, :string, array: true, default: []
  end
end
