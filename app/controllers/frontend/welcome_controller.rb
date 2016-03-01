class Frontend::WelcomeController < Frontend::ApplicationController
  skip_before_action :authenticate_user!
  before_action :load_cart

  def index
  end

  def privacy
  end

  def statement
  end

  def about
  end

  def service
  end

end
