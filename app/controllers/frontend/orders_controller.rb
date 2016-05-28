class Frontend::OrdersController < Frontend::ApplicationController
  skip_before_action :verify_authenticity_token, only: :alipay_notify
  skip_before_action :authenticate_user!, only: :alipay_notify

  def create
    build_order
    save_order(params[:is_try])
  end

  def update
    load_order
    @order.complete!
    redirect_to order_path(@order)
  end

  def show
    load_order
  end

  def alipay_done
    load_order
    alipay
    redirect_to order_build_path(:complete, :order_id => @order)
  end

  def alipay_notify
    @order = Order.find_by(number: params[:out_trade_no])
    alipay
    render text: (@order.paid? ? 'success' : '')
  end

  def wx_qr_payment
    load_order
  end

  private

  def load_orders
    @orders = order_scope
  end

  def load_order
    @order = order_scope.find_by_encrypted_id(params[:id])
  end

  def build_order
    @order ||= order_scope.new
  end

  def save_order(is_try)
    if current_cart.line_items.size > 6
      return render js: "alert('试戴商品不能超过三个');"
    end
    mark_is_try_before_buy if is_try == "true"
    @order.add_line_items_from_cart(current_cart)
    if @order.save
      respond_to do |format|
        format.html { redirect_to order_build_path(:address, :order_id => @order) }
        format.js { render js: "window.location.href='"+ order_build_path(:address, :order_id => @order) +"'" }
      end
    end
  end

  def mark_is_try_before_buy
    @order.is_try_before_buy = true
  end

  def order_scope
    current_user.orders
  end

  def alipay
    notify_params = params.except(*request.path_parameters.keys)
    if @order.pending? && Alipay::Notify.verify?(notify_params)
      @order.payments.first_or_initialize.purchase(params)
      @order.update_state_with_track!('pay', @order.user)
    end
  end

end
