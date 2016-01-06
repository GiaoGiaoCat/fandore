module Frontend::Users::OrdersHelper
  def options_for_select_with_default(object, attr)
    hash = {
      default_opt_value: nil,
      current_opt_id: object.send(attr),
      current_opt_text: ChinaCity.get(object.send(attr)),
      single: false
    }
    case attr
    when :province
      hash[:default_opt_value] = [["选择省份"]].concat(ChinaCity.list)
      hash[:current_opt_text] = ChinaCity.list
      hash[:single] = true
    when :city
      hash[:default_opt_value] = [["选择城市"]]
    when :district
      hash[:default_opt_value] = [["选择区域"]]
    end
    options_for_select_with_value(object, hash)
  end

  def options_for_select_with_value(object, hash)
    if object.new_record? && hash[:current_opt_id].blank?
      options_for_select(hash[:default_opt_value])
    else
      if hash[:single]
        options_for_select(hash[:current_opt_text], hash[:current_opt_id])
      else
        options_for_select([[hash[:current_opt_text], hash[:current_opt_id]]])
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
