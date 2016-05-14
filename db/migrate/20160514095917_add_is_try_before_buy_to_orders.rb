class AddIsTryBeforeBuyToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :is_try_before_buy, :boolean, default: false
  end
end
