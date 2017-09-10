class AddDisplayTitleToOrderStatus < ActiveRecord::Migration[5.1]
  def change
    add_column :order_statuses, :display_title, :string
  end
end
