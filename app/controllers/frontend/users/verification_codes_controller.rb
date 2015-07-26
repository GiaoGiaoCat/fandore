class Frontend::Users::VerificationCodesController < Frontend::ApplicationController
  skip_before_action :authenticate_user!

  def create
    User::VerificationCode.registration_code(params[:mobile])
  end
end