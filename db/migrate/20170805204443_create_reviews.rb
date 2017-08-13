class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :title
      t.string :text
      t.integer :score
      t.string :status, default: "Unprocessed"
      t.boolean :verified, default: false
      t.integer :user_id
      t.integer :book_id

      t.timestamps
    end
    add_index :reviews, [:user_id, :book_id, :created_at]
  end
end
