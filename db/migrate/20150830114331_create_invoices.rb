class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.references  :user, index: true
      t.integer     :billing_address_id, index: true
      t.integer     :payment_type, default: 0
      t.string      :title
      t.string      :mobile
      t.string      :code
      t.string      :number
      t.integer     :status, default: 0
      t.text        :note
      t.datetime    :invoice_date

      t.datetime    :period_start_date
      t.datetime    :period_end_date

      t.decimal     :item_total, precision: 10, scale: 2, default: 0.0, null: false
      t.decimal     :total, precision: 10, scale: 2, default: 0.0, null: false
      t.decimal     :adjustment_total, precision: 10, scale: 2, default: 0.0, null: false
      t.decimal     :payment_total, precision: 10, scale: 2, default: 0.0
      t.decimal     :promo_total, precision: 10, scale: 2, default: 0.0
      t.decimal     :shipment_total, precision: 10, scale: 2, default: 0.0, null: false

      t.timestamps null: false
    end
  end
end
