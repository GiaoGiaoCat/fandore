class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string    :number,  limit: 32
      t.decimal   :item_total, precision: 10, scale: 2, default: 0.0, null: false
      t.decimal   :total, precision: 10, scale: 2, default: 0.0, null: false
      t.string    :state
      t.decimal   :adjustment_total, precision: 10, scale: 2, default: 0.0, null: false
      t.integer   :user_id
      t.datetime  :completed_at
      # t.integer   :bill_address_id
      t.integer   :ship_address_id
      t.decimal   :payment_total, precision: 10, scale: 2, default: 0.0
      # t.integer   :shipping_method_id
      t.string    :shipment_state
      t.string    :payment_state
      t.string    :email
      t.text      :special_instructions
      # t.string    :currency
      t.string    :last_ip_address
      t.integer   :created_by_id
      t.decimal   :shipment_total, precision: 10, scale: 2, default: 0.0, null: false
      # t.decimal   :additional_tax_total, precision: 10, scale: 2, default: 0.0, null: false
      t.decimal   :promo_total, precision: 10, scale: 2, default: 0.0
      # t.string    :channel
      # t.decimal   :shipment_total, precision: 10, scale: 2, default: 0.0, null: false
      t.integer   :item_count, default: 0
      t.integer   :approver_id
      t.datetime  :approved_at
      t.boolean   :confirmation_delivered, default: false
      t.boolean   :considered_risky, default: false
      t.string    :guest_token
      t.datetime  :canceled_at
      t.integer   :canceler_id
      # t.integer   :store_id
      # t.integer   :state_lock_version, default: 0, null: false

      t.timestamps null: false
    end
  end
end
