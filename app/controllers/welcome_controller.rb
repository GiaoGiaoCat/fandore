class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!
  layout "empty"

  def index
  end
  
end
