class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.date :completed_at
      t.references :order_status, foreign_key: true
      t.float :total
      t.float :subtotal
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
