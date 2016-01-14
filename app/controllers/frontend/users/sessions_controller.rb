class Frontend::Users::SessionsController < Frontend::ApplicationController
  include Authenticatable

  # layout false

  private

  def redirect_to_url
    redirect_to root_path
  end

  def authority_verify(user)
    user.frontend_user?
  end
end
