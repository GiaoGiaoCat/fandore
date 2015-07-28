class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :post_code
      t.string :full_name
      t.string :mobile
      t.string :phone_section
      t.integer :phone_code
      t.string :phone_ext
      t.text :address_detail
      t.string :province
      t.string :district

      t.timestamps null: false
    end
  end
end
