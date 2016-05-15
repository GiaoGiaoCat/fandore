class CreateExpresses < ActiveRecord::Migration
  def change
    create_table :expresses do |t|
      t.references :order, index: true
      t.string :number, null: false
      t.string :company, null: false
      
      t.timestamps null: false
    end
  end
end
