class CreatePaymentCards < ActiveRecord::Migration[5.1]
  def change
    create_table :payment_cards do |t|
      t.string :card_number
      t.string :name
      t.string :expiry_date
      t.string :cvv
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
