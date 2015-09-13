class Backend::ApplicationController < ApplicationController
  layout ->(controller) { controller.request.xhr? ? false : 'backend' }

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to admin_path, :notice => exception.message
  end

  private
end
