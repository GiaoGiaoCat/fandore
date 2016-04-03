module ApplicationHelper
  def page_title
    if @page_title
      "#{@page_title} - VANDODO范朵朵珠宝官网"
    else
      "VANDODO范朵朵珠宝，每个女生都期待一场浪漫求婚"
    end
  end

  def page_id
    controller_names = controller_path.split('/')
    [controller_names, action_name, params[:step]].compact.flatten.join('-')
  end

  def is_active_controller(*controller_names)
    controller_names.include?(params[:controller]) ? "active" : nil
  end

  def is_active_action(action_name)
    params[:action] == action_name ? "active" : nil
  end

  def is_active_request_path(path_name)
    request.path == path_name ? "current" : nil
  end

  def format_datetime(datetime, format = "%Y-%m-%d %H:%M:%S")
    if datetime
      datetime.localtime.strftime(format)
    end
  end

  def format_date(datetime, format = "%Y-%m-%d")
    format_datetime(datetime, format)
  end
end
