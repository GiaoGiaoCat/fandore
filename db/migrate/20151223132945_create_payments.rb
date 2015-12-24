class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references  :order, index: true
      t.decimal     :amount, precision: 10, scale: 2, default: 0.0, null: false
      t.integer     :state #交易状态
      t.string      :buyer_info #买家支付宝账号/微信支付调用接口提交的终端设备号
      t.string      :out_trade_no #商户网站唯一订单号
      t.string      :transaction_id #支付宝交易号/微信订单号

      # t.integer  "source_id"
      # t.string   "source_type"
      # t.integer  "payment_method_id"
      # t.string   :response_code
      # t.string   :avs_response # 等于 transaction_id
      # t.string   :identifier
      # t.string   :cvv_response_code
      # t.string   :cvv_response_message

      t.timestamps null: false
    end
  end
end
