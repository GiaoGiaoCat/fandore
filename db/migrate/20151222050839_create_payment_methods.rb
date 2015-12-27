class CreatePaymentMethods < ActiveRecord::Migration
  def change
    create_table :payment_methods do |t|
      t.string    :name
      t.string    :description
      t.string    :type
      t.boolean   :active, default: true
      t.string    :environment
      t.boolean   :auto_capture, default: true
      t.string    :display_on
      t.datetime  :deleted_at

      t.timestamps null: false
    end

    add_index :payment_methods, ["id", "type"], name: :index_payment_methods_on_id_and_type
  end
end
