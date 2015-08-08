class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :number
      t.string :string
      t.string :item_total
      t.string :decimal
      t.string :total
      t.string :decimal
      t.string :state
      t.string :string
      t.string :adjustment_total
      t.string :decimal
      t.string :user_id
      t.string :integer
      t.string :ship_address_id
      t.string :integer
      t.string :payment_total
      t.string :decimal
      t.string :shipping_method_id
      t.string :integer
      t.string :shipment_state
      t.string :string
      t.string :payment_state
      t.string :string
      t.string :email
      t.string :string
      t.string :special_instructions
      t.string :text
      t.string :currency
      t.string :string
      t.string :last_ip_address
      t.string :string
      t.string :created_by_id
      t.string :integer
      t.string :shipment_total
      t.string :decimal
      t.string :promo_total
      t.string :decimal
      t.string :channel
      t.string :string
      t.string :item_count
      t.string :integer
      t.string :approver_id
      t.string :integer
      t.string :approved_at
      t.string :datetime
      t.string :confirmation_delivered
      t.string :boolean
      t.string :considered_risky
      t.string :boolean
      t.string :state_lock_version
      t.string :integer

      t.timestamps null: false
    end
  end
end
