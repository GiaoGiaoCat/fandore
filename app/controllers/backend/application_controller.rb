class Backend::ApplicationController < ApplicationController
  layout ->(controller) { controller.request.xhr? ? false : 'backend' }

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to admin_path, :notice => exception.message
  end

  private

  def authenticate_user!
    unless current_user && current_user.backend_user?
      redirect_to admin_sign_in_path
    end
  end
end
