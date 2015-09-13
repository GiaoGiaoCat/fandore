class Frontend::Users::SessionsController < Frontend::ApplicationController
  include Authenticatable


  private

  def redirect_to_url
    redirect_to root_path
  end

  def authority_verify(user)
    unless current_user && (User::FRONTENDROLE.include? current_user.role.to_sym)
      true
    end
  end
end
