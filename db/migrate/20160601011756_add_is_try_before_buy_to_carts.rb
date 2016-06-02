class AddIsTryBeforeBuyToCarts < ActiveRecord::Migration
  def change
    add_column :carts, :is_try_before_buy, :boolean, default: false
  end
end
