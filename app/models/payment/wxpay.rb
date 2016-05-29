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
      # :amount   => order.total * 100,
      :amount   => 1,
      :order_no => order.number,
      :channel  => "wx_pub_qr",
      :currency => "cny",
      :client_ip=> client_ip,
      :extra=> {'product_id' => order.products.first.id},
      :app => {'id' => "app_WHSmb5CuLCK0uf9u"}
    )
    pingxx_info = order.build_pingxx_info(pingxx_id: pingxx_result[:id], channel: pingxx_result[:channel], amount: pingxx_result[:amount])
    if pingxx_info.save
      wx_pub_qr = pingxx_result[:credential][:wx_pub_qr]
      qr_path = "public/uploads/wx_pub_qr/#{order.number}.png"
      RQRCode::QRCode.new( wx_pub_qr, :size => 5, :level => :h ).to_img.resize(200, 200).save(qr_path)
      Rails.application.routes.url_helpers.wx_qr_payment_order_path(order)
    end
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


# {"id"=>"evt_lhZH6kxk7IlLO4n2FiFPWr9D", "created"=>1464443420, 
#   "livemode"=>true, "type"=>"charge.succeeded", 
#   "data"=>
#       {"object"=>
#             {"id"=>"ch_eXf9aHGqPSeLOqDe14qHWbrP", 
#               "object"=>"charge", "created"=>1464443397, "livemode"=>true, 
#               "paid"=>true, "refunded"=>false, "app"=>"app_WHSmb5CuLCK0uf9u", 
#               "channel"=>"wx_pub_qr", "order_no"=>"N073120064", "client_ip"=>"0.0.0.0", "amount"=>1,
#      "amount_settle"=>1, "currency"=>"cny", "subject"=>"Crown钻石戒指", "body"=>"Crown钻石戒指,0.3CT-H-VS2", 
#      "extra"=>{"product_id"=>2016, "open_id"=>"o4QdzswK88PaUjBvsYfx8ZbDtkhI", "bank_type"=>"CFT"}, 
#      "time_paid"=>1464443419, "time_expire"=>1464450597, "time_settle"=>nil, 
#      "transaction_no"=>"4000152001201605286442541441", 
#      "refunds"=>{"object"=>"list", "url"=>"/v1/charges/ch_eXf9aHGqPSeLOqDe14qHWbrP/refunds", 
#       "has_more"=>false, "data"=>nil}, "amount_refunded"=>0, "failure_code"=>nil, 
#       "failure_msg"=>nil, "metadata"=>{}, "credential"=>{}, "description"=>nil}}, 
#       "object"=>"event", "pending_webhooks"=>1, "request"=>"iar_CWHGuTyLSiHKDW5yvLzzfv54",
#        "order"=>{"id"=>"evt_lhZH6kxk7IlLO4n2FiFPWr9D"}}





