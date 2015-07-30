class Frontend::Users::BindingEmailsController < Frontend::ApplicationController
  include Frontend::Users::PasswordsHelper
  def index
    
  end

  def show
  end

  def create
    User::EmailVerificationCode.create(to: current_user.email)
    redirect_to users_binding_email_to_email_path
  end

end