class CreateTaxons < ActiveRecord::Migration
  def change
    create_table :taxons do |t|
      t.references :taxonomy
      t.string :name, null: false
      t.string :ancestry, index: true
      
      t.timestamps null: false
    end
  end
end
