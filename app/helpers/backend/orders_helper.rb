module Backend::OrdersHelper
  def show_shipping_address(address)
    city_address = "#{ChinaCity.get(address.province)} #{ChinaCity.get(address.city)} #{ChinaCity.get(address.district)}"
    "#{city_address} #{address.address}, #{address.name}, #{address.mobile}"
  end

  def next_state_link(obj)
    class_name, event_name =
      if obj.is_try_before_buy?
        case obj.state
        when 'checkout'
          ['fa fa-send', 'close']
        when 'pending'
          ['fa fa-send', 'pay']
        when 'paid'
          ['fa fa-send', 'delivery']
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
      else
        case obj.state
        when 'checkout'
          ['fa fa-send', 'close']
        when 'pending'
          ['fa fa-send', 'pay']
        when 'paid'
          ['fa fa-send', 'filter']
        when 'filtered'
          ['fa fa-send', 'inlaid']
        when 'inlaided'
          ['fa fa-send', 'quality_check']
        when 'quality_checked'
          ['fa fa-send', 'pack']
        when 'packed'
          ['fa fa-send', 'delivery']
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
      end
    return if event_name.blank?
    btn_name = ' ' + I18n.t("views.orders.state_btn.#{event_name}")
    link_to content_tag(:i, nil, class: class_name) + btn_name, update_state_admin_order_path(@order, event: event_name), method: :put, class: 'btn btn-primary'
  end

  def show_track_info_operator_and_time(track_info)
    return unless track_info
    # operator
    format_datetime track_info[:time]
  end
end
