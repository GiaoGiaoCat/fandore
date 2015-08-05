class CreateTaxons < ActiveRecord::Migration
  def change
    create_table :taxons do |t|
      t.integer :parent_id
      t.integer :position
      t.string :name
      t.string :permalink
      t.integer :taxonomy_id
      t.integer :lft
      t.integer :rgt
      t.string :icon_file_name
      t.string :icon_content_type
      t.integer :icon_file_size
      t.datetime :icon_updated_at
      t.text :description
      t.string :meta_title
      t.string :meta_description
      t.string :meta_keywords
      t.integer :depth

      t.timestamps null: false
    end
  end
end
