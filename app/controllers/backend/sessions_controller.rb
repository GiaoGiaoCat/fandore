class Backend::SessionsController < Backend::ApplicationController
  include Authenticatable
  layout "empty"

  def create
    (build_sign_in.captcha_valid? && save_sign_in) || (render 'new')
  end

  private

  def password_faile_handler(sign_in)
    user = sign_in.user
    if user.last_pwd_failed_at.try(:today?)
      user.increment!(:pwd_failed_count)
    else
      user.update_columns(last_pwd_failed_at: Time.now, pwd_failed_count: 1)
    end
    false
  end

  def redirect_to_url
    redirect_to admin_path
  end

  def authority_verify(user)
    user.admin?
  end
end
