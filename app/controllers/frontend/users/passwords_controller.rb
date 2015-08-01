class Frontend::Users::PasswordsController < Frontend::ApplicationController
  skip_before_action :authenticate_user!
  def new
    build_password
  end

  def create
    if current_user
      build_password
      save_password or render 'new'
    else
      load_user            
      if User::PasswordChangeForm.answer_set_password(@user,params[:answer]) 
        redirect_to root_path  
      else
        redirect_to :back
      end
    end
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

  def load_user
    @user = User.find_by(email: params[:email])
    User::Question.is_answer(@user,params[:answer])
  end
end
