class AddNumberToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :number, :string
  end
end
