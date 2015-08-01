class Backend::ApplicationController < ApplicationController
  layout 'backend'

  private

  def authenticate_user!
    unless current_user && current_user.admin?
      redirect_to admin_sign_in_path
    end
  end
end
