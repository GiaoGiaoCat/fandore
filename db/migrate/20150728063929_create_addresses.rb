class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :user, index: true, foreign_key: true

      t.string :name
      t.string :zipcode
      t.string :mobile
      t.string :province
      t.string :district
      t.string :city
      t.string :address
      t.string :phone_area_code
      t.string :phone
      t.string :phone_ext_code
      t.boolean :is_default, default: false

      t.timestamps null: false
    end
  end
end
