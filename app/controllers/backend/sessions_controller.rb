class Backend::SessionsController < Backend::ApplicationController
  layout 'empty'
  skip_before_action :authenticate_user!, only: [:new]

  def new
    build_sign_in
  end

private

  def build_sign_in
    @sign_in ||= User::LoginForm.new(sign_in_params)
  end

  def sign_in_params
    user_params = params[:user_login_form]
    user_params ? user_params.permit(:username, :password) : {}
  end
end
