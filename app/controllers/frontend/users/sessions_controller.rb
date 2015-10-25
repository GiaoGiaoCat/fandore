class Frontend::Users::SessionsController < Frontend::ApplicationController
  include Authenticatable

  private

  def redirect_to_url
    redirect_to(last_request_url || root_path)
  end

  def authority_verify(user)
    user.frontend_user?
  end
end
