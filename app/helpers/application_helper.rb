module ApplicationHelper
  def is_active_controller(*controller_names)
    controller_names.include?(params[:controller]) ? "active" : nil
  end

  def is_active_action(action_name)
    params[:action] == action_name ? "active" : nil
  end

  def format_datetime(datetime, format = "%Y-%m-%d %H:%M:%S")
    if datetime
      datetime.strftime(format)
    end
  end

  def format_date(datetime, format = "%Y-%m-%d")
    format_datetime(datetime, format)
  end
end
