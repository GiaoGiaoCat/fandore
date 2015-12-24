class Payment < ActiveRecord::Base
  # table name
  # extends ...................................................................
  # includes ..................................................................
  include PaymentStates
  # constants .................................................................
  # related macros ............................................................
  # relationships .............................................................
  belongs_to :order, touch: true, inverse_of: :payments
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
  # protected instance methods ................................................
  # private instance methods ..................................................
end