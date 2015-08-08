class User::EmailVerificationCode < User::VerificationCode
  # extends ...................................................................
  # includes ..................................................................
  # constants .................................................................
  # related macros ............................................................
  # relationships .............................................................
  # validations ...............................................................
  validates :to, format: { with: Fandore::Regex::EMAIL_REGEX }
  # callbacks .................................................................
  # scopes ....................................................................
  # other macros (like devise's) ..............................................
  # class methods .............................................................
  # public instance methods ...................................................
  # protected instance methods ................................................
  # private instance methods ..................................................
  private

  def generate_code
    self.code = SecureRandom.hex
  end

  def package_url
    case method.to_sym
    when :send_verification
      Rails.application.routes.url_helpers.new_activation_url(code: code, host: 'http://fandore.net')
    when :found_password
      Rails.application.routes.url_helpers.new_password_url(email: email, opt_code: opt_code, host: 'http://fandore.net')
    end
  end

  def project_code
    case method.to_sym
    when :send_verification
      Figaro.env.mail_project_verification
    when :found_password
      Figaro.env.mail_project_found_password
    end
  end

  def send_notification
    url = package_url
    pusher = Submail.pusher(Figaro.env.mail_app_id, Figaro.env.mail_signature)
    pusher.mail_xsend(to, project_code, { url: url }, { url: url })
  end
end
