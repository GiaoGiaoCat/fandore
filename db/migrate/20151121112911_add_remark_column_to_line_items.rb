class AddRemarkColumnToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :remark, :string
    remove_column :carts, :remark
  end
end
