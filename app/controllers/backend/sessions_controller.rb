class Backend::SessionsController < Backend::ApplicationController
  include Authenticatable

  private

  def redirect_to_url
    redirect_to admin_path
  end
end
