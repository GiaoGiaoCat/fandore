module Frontend::Users::BindingEmailsHelper
  def email_path(user)
    email = user.email
    if email.present?
      email.include?("gmail") ? "http://gmail.google.com/" :  "http://mail.#{email.split('@')[1]}"
    else
      users_profile_edit_path
    end
  end
end

