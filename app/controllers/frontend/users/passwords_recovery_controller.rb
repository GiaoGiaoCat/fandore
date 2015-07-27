class Frontend::Users::PasswordsRecoveryController < Frontend::ApplicationController
  skip_before_action :authenticate_user!

  def new
    @password = User::PasswordRecovery.new
  end

  def create
    if User::PasswordRecovery.verify(password_params[:mobile],password_params[:verification_code])
      redirect_to users_new_password_path(mobile: password_params[:mobile], verification_code: password_params[:verification_code])
    else
      redirect_to :back
    end
  end

  def get_otp_code
    code = User::PasswordRecovery.get_otp_code(params[:mobile])
    #短信发送验证码功能，验证码：code
    pusher = Submail.pusher('10330', '1f1bc2a6b1689a7ee02695a1967d7322')
    pusher.message_xsend(params[:mobile], 'twMG94', { sms_reg_code: code })
    render text: ''
  end

  def new_password
    if User::PasswordRecovery.verify(params[:mobile],params[:verification_code])
      @password = User::PasswordRecovery.new
      @user = User.find_by(mobile: params[:mobile])
    else
      redirect_to users_forget_password_path
    end
  end

  def update
    @user = User.find_by(id: new_password_params[:user_id])
    if new_password_params[:password] == new_password_params[:password_confirmation]
      @user.update(:password => new_password_params[:password])
      redirect_to root_path
    else
      redirect_to :back
    end
  end

  private
  def password_params
    password_params = params[:user]
    password_params ? password_params.permit(:mobile, :verification_code) : {}
  end

  def new_password_params
    new_password_params = params[:user]
    new_password_params ? new_password_params.permit(:password, :password_confirmation, :user_id) : {}
  end
end
