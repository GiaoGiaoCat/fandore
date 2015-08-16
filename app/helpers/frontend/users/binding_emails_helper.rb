module Frontend::Users::BindingEmailsHelper
  def email_path
    if current_user && current_user.email
      current_user.email.to_email_url
    end
  end
end

