module Frontend::Users::OrdersHelper
  def next_state_button(obj)
    class_name, event_name =
      case obj.state
      when 'checkout'
        ['fa fa-send', 'close']
      when 'pending'
        ['fa fa-send', 'close']
        # ['fa fa-send', 'pay']
      when 'paid'
        ['', '']
      when 'filtered'
        ['', '']
      when 'inlaided'
        ['', '']
      when 'quality_checked'
        ['', '']
      when 'packed'
        ['', '']
      when 'delivered'
        ['fa fa-send', 'complete']
      when 'completed'
        ['', '']
        # ['fa fa-send', 'close']
      when 'canceled'
        ['', '']
        # ['fa fa-send', 'quality_check']
      when 'closed'
        ['', '']
        # ['fa fa-send', 'quality_check']
      when 'refunded'
        ['', '']
        # ['fa fa-send', 'quality_check']
      when 'resumed'
        ['', '']
        # ['fa fa-send', 'quality_check']
      end
    return if event_name.blank?
    btn_name = ' ' + I18n.t("views.orders.state_btn.#{event_name}")
    link_to btn_name, update_state_order_path(obj, event: event_name), method: :put, class: 'btn btn-default btn-sm'
  end
end
