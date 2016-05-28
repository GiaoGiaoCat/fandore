class Payment::Wxpay < Payment::PaymentMethod
  # table name
  # extends ...................................................................
  # includes ..................................................................
  # constants .................................................................
  # related macros ............................................................
  # relationships .............................................................
  # validations ...............................................................
  # callbacks .................................................................
  # scopes ....................................................................
  # other macros (like devise's) ..............................................
  # class methods .............................................................
  # public instance methods ...................................................
  def pay_url(order, client_ip="0.0.0.0")
    pingxx_result = Pingpp::Charge.create(
      :subject  => order.order_name,
      :body     => order.products.map(&:name).join(","),
      :amount   => order.total,
      :order_no => order.number,
      :channel  => "wx_pub_qr",
      :currency => "cny",
      :client_ip=> client_ip,
      :extra=> {'product_id' => order.products.first.id},
      :app => {'id' => "app_WHSmb5CuLCK0uf9u"}
    )
    wx_pub_qr = pingxx_result[:credential][:wx_pub_qr]
    qr_path = "public/#{order.number}.png"
    RQRCode::QRCode.new( wx_pub_qr, :size => 5, :level => :h ).to_img.resize(200, 200).save(qr_path)
    "/orders/#{order.number}/wx_qr_payment"
  end
  # protected instance methods ................................................
  # private instance methods ..................................................
end

# {
    #     "id": "ch_OWzH8GX98aLOaLiT8SPCqv5K",
    #     "object": "charge",
    #     "created": 1464404145,
    #     "livemode": true,
    #     "paid": false,
    #     "refunded": false,
    #     "app": "app_WHSmb5CuLCK0uf9u",
    #     "channel": "wx_pub_qr",
    #     "order_no": "N912340983",
    #     "client_ip": "127.0.0.1",
    #     "amount": 7900,
    #     "amount_settle": 7900,
    #     "currency": "cny",
    #     "subject": "Whispper钻石戒指",
    #     "body": "Whispper钻石戒指,0.3CT-H-VS2",
    #     "extra": {"product_id":2014},
    #     "time_paid": null,
    #     "time_expire": 1464411345,
    #     "time_settle": null,
    #     "transaction_no": null,
    #     "refunds": {"object":"list","url":"/v1/charges/ch_OWzH8GX98aLOaLiT8SPCqv5K/refunds","has_more":false,"data":[]},
    #     "amount_refunded": 0,
    #     "failure_code": null,
    #     "failure_msg": null,
    #     "metadata": {},
    #     "credential": {"object":"credential","wx_pub_qr":"weixin://wxpay/bizpayurl?pr=QiIrd6Z"},
    #     "description": null
    #   }