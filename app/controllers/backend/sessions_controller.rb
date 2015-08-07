class Backend::SessionsController < Backend::ApplicationController
  include Authenticatable
  layout "empty"

  private

  def redirect_to_url
    redirect_to admin_path
  end

  def authority_verify(user)
    user.admin?
  end
end
