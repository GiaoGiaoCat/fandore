class Frontend::Users::RegistrationsController < Frontend::ApplicationController
  include Registerable

  skip_before_action :authenticate_user!
  layout 'empty'

  private

  def user_scope
    User::RegistrationForm
  end

  def save_user
    if @user.save
       @user.update_columns(registe_ip: request.remote_ip)
      redirect_to root_path
    end
  end

end
