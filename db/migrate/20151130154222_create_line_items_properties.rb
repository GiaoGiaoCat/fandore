class CreateLineItemsProperties < ActiveRecord::Migration
  def change
    create_table :line_items_properties do |t|
      t.string      :value
      t.references  :line_item, index: true
      t.references  :property, index: true
      t.integer     :position, default: 0, index: true

      t.timestamps null: false
    end
  end
end
