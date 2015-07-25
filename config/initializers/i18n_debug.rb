if Rails.env.development?
  i18n_log = Logger.new("#{Rails.root}/log/i18n.log")  # create log file
  I18n::Debug.logger = i18n_log
end
