class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.integer :order_id
      t.string :title
      t.string :type_name

      t.timestamps null: false
    end
  end
end
