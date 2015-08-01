class Backend::ApplicationController < ApplicationController
  layout ->(controller) { controller.request.xhr? ? false : 'backend' }

  private

  def authenticate_user!
    unless current_user && current_user.admin?
      redirect_to admin_sign_in_path
    end
  end
end
