class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.references  :variant, index: true
      t.decimal     :price,  precision: 10, scale: 2
      t.string      :currency

      t.timestamps null: false
    end
  end
end
