module Frontend::Users::BindingEmailsHelper
  def email_path(user)
    user.email_url
  end
end

