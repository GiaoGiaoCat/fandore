class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :picture
      t.string :viewable_type
      t.integer :viewable_id
      t.integer :position, default: 0
      t.timestamps null: false
    end
  end
end
