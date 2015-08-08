class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :number
      t.decimal :item_total
      t.decimal :total
      t.string :state
      t.decimal :adjustment_total
      t.integer :user_id
      t.integer :ship_address_id
      t.decimal :payment_total
      t.integer :shipping_method_id
      t.string :shipment_state
      t.string :payment_state
      t.string :email
      t.text :special_instructions
      t.string :currency
      t.string :last_ip_address
      t.integer :created_by_id
      t.decimal :shipment_total
      t.decimal :promo_total
      t.string :channel
      t.integer :item_count
      t.integer :approver_id
      t.datetime :approved_at
      t.boolean :confirmation_delivered
      t.boolean :considered_risky
      t.integer :state_lock_version

      t.timestamps null: false
    end
  end
end
