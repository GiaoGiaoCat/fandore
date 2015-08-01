class Frontend::Users::SessionsController < Frontend::ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    build_sign_in
  end

  def create
    build_sign_in
    save_sign_in or render 'new'
  end

  def destroy
    sign_out
  end

private

  def build_sign_in
    @sign_in ||= User::LoginForm.new(sign_in_params)
  end

  def save_sign_in
    if @sign_in.save
      @sign_in.user.update_tracked_fields!(request)
      session[:user_id] = @sign_in.user.id
      if @sign_in.user.admin?
        redirect_to admin_path
      else
        redirect_to root_path
      end
    end
  end

  def sign_out
    session[:user_id] = nil
    if @current_user.admin?
      redirect_to admin_sign_in_path
    else
      redirect_to sign_in_path
    end
    @current_user = nil
  end

  def sign_in_params
    user_params = params[:user_login_form]
    user_params ? user_params.permit(:username, :password) : {}
  end

end
