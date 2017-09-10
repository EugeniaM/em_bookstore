class AddDeliveryToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :delivery, :float, default: 0.0
  end
end
