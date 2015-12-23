class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references  :order, index: true
      t.decimal  :amount, precision: 10, scale: 2, default: 0.0, null: false
      # t.integer  "source_id"
      # t.string   "source_type"
      # t.integer  "payment_method_id"
      t.string   :state #交易状态
      # t.string   :response_code
      # t.string   :avs_response
      # t.string   :identifier
      # t.string   :cvv_response_code
      # t.string   :cvv_response_message

      t.string   :out_trade_no #商户网站唯一订单号
      t.string   :transaction_id #支付宝交易号/微信订单号

      t.timestamps null: false
    end
  end
end
