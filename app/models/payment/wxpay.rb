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
  def pay_url(order)
    Alipay::Service.create_direct_pay_by_user_url(
      out_trade_no: order.number,
      subject: order.order_name,
      total_fee: order.total,
      return_url: url_helpers.alipay_done_order_url(order, host: Figaro.env.site_domain),
      notify_url: url_helpers.alipay_notify_orders_url(host: Figaro.env.site_domain)
    )
  end
  # protected instance methods ................................................
  # private instance methods ..................................................
end
