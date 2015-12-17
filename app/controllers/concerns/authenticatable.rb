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

    respond_to do |format|
      if save_sign_in
        format.html { redirect_to_url }
        format.js
      else
        format.html { render :new }
        format.js
      end
    end
  end

  def destroy
    sign_out
    redirect_to_url
  end

  private

  def build_sign_in
    @sign_in ||= User::LoginForm.new(sign_in_params)
  end

  def sign_in_params
    user_params = params[:user_login_form]
    user_params ? user_params.permit(:username, :password, :captcha, :captcha_key) : {}
  end

  def save_sign_in
    if @sign_in.save && authority_verify(@sign_in.user) && locked_verify(@sign_in.user)
      @sign_in.user.update_tracked_fields!(request)
      session[:user_id] = @sign_in.user.id
    else
      password_faile_handler
    end
  end

  def password_faile_handler
    @sign_in.user && @sign_in.user.increment_or_reset_failed_sign_in_count! and false
  end

  def sign_out
    session[:user_id] = nil
    @current_user = nil
  end

  def locked_verify(user)
    user.should_unlock? ? user.unlock! : user.unlocked?
  end

  def redirect_to_url
    raise NotImplementedError, 'Must be implemented by who mixins me.'
  end

  def authority_verify(user)
    raise NotImplementedError, 'Must be implemented by who mixins me.'
  end


end
