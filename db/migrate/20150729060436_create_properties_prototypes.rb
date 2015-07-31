class CreatePropertiesPrototypes < ActiveRecord::Migration
  def change
    create_table :properties_prototypes, id: false do |t|
      t.references :property, index: true, foreign_key: true
      t.references :prototype, index: true, foreign_key: true
    end
  end
end
