class Frontend::Users::PasswordByEmailsController < Frontend::ApplicationController
  skip_before_action :authenticate_user!

  def new
    @user = User.new
  end

  def create
    load_user
    if @user
      User::EmailVerificationCode.create(to: @user.email, method: :found_password)
    else
      redirect_to users_passwords_email_new_path
    end
  end

  private

  def load_user
    @user = User.find_by(user_params)
  end

  def user_params
    user_params = params[:user]
    user_params ? user_params.permit(:email) : {}
  end

end