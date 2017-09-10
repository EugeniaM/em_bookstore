class AddColumnsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :coupon_code, :string, default: '1234567'
    add_column :users, :coupon_used, :boolean, default: false
  end
end
