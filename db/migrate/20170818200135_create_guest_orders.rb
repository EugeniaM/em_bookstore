class CreateGuestOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :guest_orders do |t|
      t.references :order_status, foreign_key: true
      t.float :total
      t.float :subtotal
      t.string :session_id

      t.timestamps
    end
  end
end
