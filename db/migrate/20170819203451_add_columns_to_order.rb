class AddColumnsToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :discount, :integer, default: 0
  end
end
