class AddColumnsToBook < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :publication_year, :string
    add_column :books, :dimensions, :string
    add_column :books, :materials, :string
  end
end
