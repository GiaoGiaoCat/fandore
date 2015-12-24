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
    case step
    when :address
      @order.update_state_with_track!('started_processing', current_user)
    when :payment
      @order.update_state_with_track!('pend', current_user)
      alipay_url = @order.pay_url
      redirect_to alipay_url and return
    end
    render_wizard @order
  end

  private

  def load_order
    @order = order_scope.find_by_encrypted_id(params[:order_id])
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
