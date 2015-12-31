module Frontend::Users::OrdersHelper
  def show_next_state(obj)
    next_state =
      case obj.state
      when 'checkout'
        'processing'
      when 'processing'
        'pending'
      when 'pending'
        'paid'
      when 'paid'
        'filtered'
      when 'filtered'
        'inlaided'
      when 'inlaided'
        'quality_checked'
      when 'quality_checked'
        'packed'
      when 'packed'
        'delivered'
      when 'delivered'
        'completed'
      else
        ''
      end
    I18n.t("views.orders.states.#{next_state}")
  end

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
    link_to btn_name, update_state_order_path(obj, event: event_name), method: :put, class: 'link'
  end
end
