class AddColumnsToGuestOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :guest_orders, :discount, :integer, default: 0
  end
end
