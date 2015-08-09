module ApplicationHelper
  def page_title
    if @page_title
      title = @page_title
    else
      step_name = params[:step].blank? ? '' : params[:step].underscore
      controller_names = controller_path.split('/')
      title = t("#{action_name}.page_title", {
        :scope => "#{controller_names.join('.')}",
        :default => [:"#{step_name}.page_title", "#{controller_path}##{action_name}"]
      })
    end

    "#{title} - Fandore"
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

  def format_datetime(datetime, format = "%Y-%m-%d %H:%M:%S")
    if datetime
      datetime.strftime(format)
    end
  end

  def format_date(datetime, format = "%Y-%m-%d")
    format_datetime(datetime, format)
  end
end
