class Frontend::Users::VerificationCodesController < Frontend::ApplicationController
  skip_before_action :authenticate_user!

  def create
    builde_v_code
    save_v_code
    render text: ''
  end

  private

  def builde_v_code
    @v_code = User::MobileVerificationCode.new(params[:v_code].permit!)
  end

  def save_v_code
    @v_code.save
  end

end
