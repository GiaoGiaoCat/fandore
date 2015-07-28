class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string   :name, default: "", null: false
      t.text     :description
      t.datetime :available_on
      t.datetime :deleted_at
      t.string   :meta_title
      t.string   :meta_keywords
      t.text     :meta_description
      t.string   :spu, default: "", null: false
      # t.integer  :tax_category_id
      # t.integer  :shipping_category_id
      # t.string   :slug
      t.boolean  :promotionable, default: true
      # maybe remove to a model
      # t.text     :detail

      t.timestamps null: false
    end

    add_index :products, ['available_on'], name: :products_available_on, length: { available_on: 255 }
    add_index :products, ['deleted_at'], name: :products_deleted_at, length: { deleted_at: 255 }

    # add_index :products, :slug, unique: true
    # add_index :products, :shipping_category_id, unique: true
    # add_index :products, :tax_category_id, unique: true
  end
end
