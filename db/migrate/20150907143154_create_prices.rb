class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.decimal :price
      t.string :currency
      t.integer :variant_id

      t.timestamps null: false
    end
  end
end
