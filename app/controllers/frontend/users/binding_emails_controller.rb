class Frontend::Users::BindingEmailsController < Frontend::ApplicationController
  def index
    
  end

  def show
    @email_path = "http://mail.#{current_user.email.split('@')[1]}"
  end

  def create
    User::EmailVerificationCode.create(to: current_user.email)
    redirect_to users_binding_email_to_email_path
  end

end