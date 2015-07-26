module Registerable
  extend ActiveSupport::Concern

  def new
    build_user
  end

  def create
    build_user
    if User::VerificationCode.verify_code(user_params["mobile"]) == verification_code_params[:verification_code]
      save_user or render 'new'
    else
      render 'new'
    end

  end

  private

  def build_user
    @user ||= User::RegistrationForm.new(user_params)
  end

  def save_user
    # Example: redirect_to admin_users_path if @user.save
    raise NotImplementedError, 'Must be implemented by who mixins me.'
  end

  def user_params
    user_params = params[:user]
    user_params ? user_params.permit(:email, :mobile, :password, :password_confirmation) : {}
  end

  def verification_code_params
    verification_code_params = params[:user]
    verification_code_params ? verification_code_params.permit(:verification_code) : {}
  end

end
