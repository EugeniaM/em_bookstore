class AddCoversToBook < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :covers, :string, array: true, default: []
  end
end
