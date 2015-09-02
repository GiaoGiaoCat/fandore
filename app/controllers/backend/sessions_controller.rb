class Backend::SessionsController < Backend::ApplicationController
  include Authenticatable
  layout "empty"


  private

  def save_sign_in
    @sign_in.captcha_valid? && super
  end

  def redirect_to_url
    redirect_to admin_path
  end

  def authority_verify(user)
    user.admin?
  end
end
