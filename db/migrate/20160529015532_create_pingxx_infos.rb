class CreatePingxxInfos < ActiveRecord::Migration
  def change
    create_table :pingxx_infos do |t|
      t.string :pingxx_id
      t.string :channel
      t.string :paid
      t.integer :amount
      t.integer :order_id

      t.timestamps null: false
    end
    add_index :pingxx_infos, :pingxx_id
    add_index :pingxx_infos, :order_id
  end
end
