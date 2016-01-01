class Frontend::Users::PasswordsController < Frontend::ApplicationController

  skip_before_action :authenticate_user!

  def new
    if current_user || load_user
      build_password
    else
      redirect_to :back
    end
  end

  def create
    build_password
    respond_to do |format|
      if @password.save
        format.html
        format.js
      else
        format.html { render :new }
        format.js
      end
    end
  end

  private

  def build_password
    @password ||= User::PasswordChangeForm.new(password_params.merge(username: current_user.mobile))
  end

  def password_params
    user_params = params[:user_password_change_form]
    user_params ? user_params.permit(:username, :password, :new_password, :password_confirmation) : {}
  end

  def load_user
    @user = User.find_by(email: params[:email])
    @user.authenticate_otp(params[:opt_code], drift: 60)
  end
end
