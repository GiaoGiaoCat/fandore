class Frontend::WelcomeController < Frontend::ApplicationController
  skip_before_action :authenticate_user!
  before_action :load_cart

  def index
    @channel = 'home'
  end

  def account_safe
  end

  def user_center
  end

end
