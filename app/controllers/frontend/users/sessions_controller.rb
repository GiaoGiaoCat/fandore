class Frontend::Users::SessionsController < Frontend::ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]
  layout 'empty'

  def new
    build_sign_in
  end

  def create
    build_sign_in
    save_sign_in or render 'new'
  end

  def destroy
    sign_out
    redirect_to root_path
  end

private

  def build_sign_in
    @sign_in ||= User::LoginForm.new(sign_in_params.merge(remote_ip: request.remote_ip))
  end

  def save_sign_in
    if @sign_in.save
      session[:user_id] = @sign_in.user.id
      redirect_to root_path
    end
  end


  def sign_out
    session[:user_id] = nil
    @current_user = nil
  end

  def sign_in_params
    user_params = params[:user_login_form]
    user_params ? user_params.permit(:username, :password) : {}
  end

end
