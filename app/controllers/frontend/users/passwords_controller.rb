class Frontend::Users::PasswordsController < Frontend::ApplicationController
  
  def new
    build_password
  end

  def create
    build_password
    save_password or render 'new'
  end

  private

  def build_password
    @password ||= User::PasswordChangeForm.new(password_params)
  end

  def save_password
    if @password.save
      session[:user_id] = nil
      @current_user = nil
      redirect_to root_path
    end
  end

  def password_params
    user_params = params[:user_password_change_form]
    user_params ? user_params.permit(:username, :password, :new_password, :password_confirmation) : {}
  end

end
