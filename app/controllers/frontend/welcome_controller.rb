class Frontend::WelcomeController < Frontend::ApplicationController
  skip_before_action :authenticate_user!

  def index
  end

  def account_safe
  end

  def user_center
  end

end
