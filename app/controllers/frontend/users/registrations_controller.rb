class Frontend::Users::RegistrationsController < Frontend::ApplicationController
  include Registerable

  skip_before_action :authenticate_user!
  layout 'empty'

  private

  def user_scope
    User::RegistrationForm
  end

  def save_user
    redirect_to root_path if @user.save
  end

end
