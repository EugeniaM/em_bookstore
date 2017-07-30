class AddOrderCounterToBook < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :order_counter, :integer, default: 0
  end
end
