class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!
  layout "empty"

  def index
  end

  def account_safe
  end

  def user_center
  end

end
