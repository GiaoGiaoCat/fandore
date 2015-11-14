class Frontend::Orders::BuildController < Frontend::ApplicationController

  include Wicked::Wizard

  before_action :load_cart

  # steps :address, :delivery, :payment, :confirm, :complete
  # steps :address, :invoice, :payment, :complete
  steps :address, :payment, :complete

  def show
    load_order
    render_wizard
  end

  def update
    load_order
    build_order
    save_order
    if step == :address
      @order.checkout!
    end
    if step == :payment
      @order.pay!
      alipay_url = Alipay::Service.create_direct_pay_by_user_url(
              out_trade_no: "TEST20150401000-#{@order.id.to_s}",
              subject: 'Order Name',
              total_fee: 0.01,
              return_url: 'https://example.com/orders/20150401000-0001',
              notify_url: 'https://example.com/orders/20150401000-0001/notify'
            )
      redirect_to alipay_url and return
    end
    render_wizard @order
  end



  private

  def load_order
    @order = order_scope.find(params[:order_id])
  end

  def build_order
    @order ||= order_scope.new
    @order.attributes = order_params
  end

  def save_order
    @order.save
  end

  def order_params
    order_params = params[:order]
    # order_params ? order_params.permit(:sku, :price, :position, option_value_ids: [], variant_properties_attributes: variant_properties_attributes) : {}
    order_params ? order_params.permit! : {}
  end

  def order_scope
    # Order
    current_user.orders
  end

end
