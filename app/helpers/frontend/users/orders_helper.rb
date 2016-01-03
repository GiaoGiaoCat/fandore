module Frontend::Users::OrdersHelper
  def options_for_select_with_default(object, attr)
    case attr
    when :province
      if object.new_record?
        options_for_select([["选择省份"]].concat(ChinaCity.list))
      else
        options_for_select(ChinaCity.list, object.send(attr))
      end
    when :city
      if object.new_record?
        options_for_select([["选择城市"]])
      else
        options_for_select([[ChinaCity.get(object.send(attr)), object.send(attr)]])
      end
    when :district
      if object.new_record?
        options_for_select([["选择区域"]])
      else
        options_for_select([[ChinaCity.get(object.send(attr)), object.send(attr)]])
      end
    end

  end

  def show_next_state(obj)
    next_state =
      case obj.state
      when 'checkout' then 'processing'
      when 'processing' then 'pending'
      when 'pending' then 'paid'
      when 'paid' then 'filtered'
      when 'filtered' then 'inlaided'
      when 'inlaided' then 'quality_checked'
      when 'quality_checked' then 'packed'
      when 'packed' then 'delivered'
      when 'delivered' then 'completed'
      else
        ''
      end
    I18n.t("views.orders.states.#{next_state}")
  end

  def next_state_button(obj)
    class_name, event_name =
      case obj.state
      when 'checkout' then ['fa fa-send', 'close']
      when 'pending' then ['fa fa-send', 'close']
      when 'paid' then ['', '']
      when 'filtered' then ['', '']
      when 'inlaided' then ['', '']
      when 'quality_checked' then ['', '']
      when 'packed' then ['', '']
      when 'delivered' then ['fa fa-send', 'complete']
      when 'completed' then ['', '']
      when 'canceled' then ['', '']
      when 'closed' then ['', '']
      when 'refunded' then ['', '']
      when 'resumed' then ['', '']
      end
    return if event_name.blank?
    btn_name = ' ' + I18n.t("views.orders.state_btn.#{event_name}")
    link_to btn_name, update_state_order_path(obj, event: event_name), method: :put, remote: true, class: 'link'
  end
end
