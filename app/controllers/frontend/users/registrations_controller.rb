class Frontend::Users::RegistrationsController < Frontend::ApplicationController
  include Registerable

  skip_before_action :authenticate_user!

  layout false

  def create
    build_user
    save_user
  end

  private

  def user_scope
    User::RegistrationForm
  end

  def save_user
    if @user.save
      @user.update_tracked_fields!(request)
      session[:user_id] = @user.id
      redirect_to root_path
    end
  end

end
