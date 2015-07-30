module Frontend::Users::BindingEmailsHelper
  def email_path
    "http://mail.#{current_user.email.split('@')[1]}"
  end
end

