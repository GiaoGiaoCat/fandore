class Backend::SessionsController < Backend::ApplicationController
  include Authenticatable
  layout "empty"

  def create
    binding.pry
    build_sign_in.valid_with_captcha?
    save_sign_in or render 'new'
  end

  private

  def redirect_to_url
    redirect_to admin_path
  end

  def authority_verify(user)
    user.admin?
  end
end
