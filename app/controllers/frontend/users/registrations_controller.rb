class Frontend::Users::RegistrationsController < Frontend::ApplicationController
  skip_before_action :authenticate_user!

  def new
    build_user
  end

  def create
    build_user
    save_user or render 'new'
  end

private

  def build_user
    @user ||= User::RegistrationForm.new(user_params)
  end

  def save_user
    if @user.save
      redirect_to root_path
    end
  end

  def user_params
    user_params = params[:user]
    user_params ? user_params.permit(:email, :mobile, :password, :password_confirmation) : {}
  end

end
