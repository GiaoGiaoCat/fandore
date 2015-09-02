class Backend::SessionsController < Backend::ApplicationController
  include Authenticatable
  layout "empty"

  def create
    (build_sign_in.captcha_valid? && save_sign_in) || (render 'new')
  end

  private

  def redirect_to_url
    redirect_to admin_path
  end

  def authority_verify(user)
    user.admin?
  end
end
