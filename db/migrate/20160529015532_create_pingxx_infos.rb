class CreatePingxxInfos < ActiveRecord::Migration
  def change
    create_table :pingxx_infos do |t|
      t.string :pingxx_id
      t.string :channel
      t.boolean :paid
      t.integer :amount
      t.integer :amount_settle
      t.integer :order_id
      t.string :transaction_no
      t.string :time_paid
      t.string :time_expire

      t.timestamps null: false
    end
    add_index :pingxx_infos, :pingxx_id
    add_index :pingxx_infos, :order_id
  end
end
