class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :short_description
      t.string :full_description
      t.float :price

      t.timestamps
    end
  end
end
