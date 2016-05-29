class Payment < ActiveRecord::Base
  # table name
  # extends ...................................................................
  # includes ..................................................................
  include PaymentStates
  # constants .................................................................
  # related macros ............................................................
  # relationships .............................................................
  belongs_to :order, touch: true, inverse_of: :payments
  belongs_to :payment_method, class_name: 'Payment::PaymentMethod', inverse_of: :payments
  # validations ...............................................................
  # callbacks .................................................................
  # scopes ....................................................................
  # other macros (like devise's) ..............................................
  # class methods .............................................................
  # public instance methods ...................................................
  def purchase(params)
    options = {
      amount: params[:total_fee],
      out_trade_no: params[:out_trade_no],
      transaction_id: params[:trade_no],
      buyer_info: params[:buyer_email]
    }
    self.attributes = options
    complete!
  end

  def pingxx_purchase(params)
    options = {
      amount: params[:amount],
      transaction_id: params[:transaction_no]
    }
    self.attributes = options
    pingxx_options = {
      paid: params[:paid],
      amount_settle: params[:amount_settle],
      transaction_no: params[:transaction_no],
      time_paid: params[:time_paid]
    }
    self.order.pingxx_info.update(pingxx_options)
    complete!
  end
  # protected instance methods ................................................
  # private instance methods ..................................................
end

