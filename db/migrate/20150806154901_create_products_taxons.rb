class CreateProductsTaxons < ActiveRecord::Migration
  def change
    create_table :products_taxons do |t|
      t.references :taxon, index: true
      t.references :product, index: true
      t.integer :position, default: 0, index: true

      t.timestamps null: false
    end
  end
end
