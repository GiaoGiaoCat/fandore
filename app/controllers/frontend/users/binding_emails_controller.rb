class Frontend::Users::BindingEmailsController < Frontend::ApplicationController
  def index
  end

  def show
  end

  def create
    User::EmailVerificationCode.create(to: current_user.email)
    redirect_to binding_email_path(id: current_user)
  end

end
