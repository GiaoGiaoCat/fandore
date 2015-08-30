class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string    :number, limit: 32, index: true
      t.string    :email
      t.integer   :user_id, index: true
      t.text      :special_instructions
      t.integer   :shipping_address_id, index: true
      t.integer   :billing_address_id, index: true
      t.integer   :item_count, default: 0
      t.string    :guest_token, index: true

      # 以下字段记录订单状态
      t.integer   :state
      # t.string    :shipment_state
      # t.string    :payment_state

      # 以下字段记录订单金额
      t.decimal   :item_total, precision: 10, scale: 2, default: 0.0, null: false
      t.decimal   :total, precision: 10, scale: 2, default: 0.0, null: false
      t.decimal   :adjustment_total, precision: 10, scale: 2, default: 0.0, null: false
      t.decimal   :payment_total, precision: 10, scale: 2, default: 0.0
      t.decimal   :promo_total, precision: 10, scale: 2, default: 0.0
      t.decimal   :shipment_total, precision: 10, scale: 2, default: 0.0, null: false

      # 以下字段辅助记录订单状态和操作信息
      t.integer   :created_by_id, index: true
      t.string    :last_ip_address
      t.datetime  :completed_at, index: true
      t.integer   :approver_id, index: true
      t.datetime  :approved_at
      t.integer   :canceler_id
      t.datetime  :canceled_at
      t.boolean   :confirmation_delivered, default: false, index: true

      t.integer   :invoice_id, index: true
      # 以下字段暂时无用
      # t.decimal   :additional_tax_total, precision: 10, scale: 2, default: 0.0, null: false
      # t.integer   :shipping_method_id, index: true
      # t.string    :currency
      # t.string    :channel
      # t.boolean   :considered_risky, default: false, index: true
      # t.integer   :store_id
      # t.integer   :state_lock_version, default: 0, null: false

      t.timestamps null: false
    end

    add_index :orders, [:user_id, :created_by_id]
  end
end
