class CreateOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|
      t.references :book, foreign_key: true
      t.references :order, foreign_key: true
      t.float :unit_price
      t.float :total_price
      t.integer :quantity

      t.timestamps
    end
  end
end
