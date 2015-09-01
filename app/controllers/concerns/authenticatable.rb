module Authenticatable
  extend ActiveSupport::Concern

  included do
    skip_before_action :authenticate_user!, only: [:new, :create]
  end

  def new
    build_sign_in
  end

  def create
    build_sign_in
    save_sign_in or render 'new'
  end

  def destroy
    sign_out
    build_sign_in and render 'new'
  end

  private

  def build_sign_in
    @sign_in ||= User::LoginForm.new(sign_in_params)
  end

  def sign_in_params
    user_params = params[:user_login_form] && params[:user_login_form].permit(:username, :password) || {}
    user_params.merge(captcha: params[:captcha], captcha_key: params[:captcha_key])
  end

  def save_sign_in
    if @sign_in.save && authority_verify(@sign_in.user)
      @sign_in.user.update_tracked_fields!(request)
      session[:user_id] = @sign_in.user.id
      redirect_to_url
    else
      password_faile_handler(@sign_in)
      false
    end
  end

  def password_faile_handler(user)
    false
  end


  def sign_out
    session[:user_id] = nil
    @current_user = nil
  end

  def redirect_to_url
    raise NotImplementedError, 'Must be implemented by who mixins me.'
  end

  def authority_verify(user)
    raise NotImplementedError, 'Must be implemented by who mixins me.'
  end

end
