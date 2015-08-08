class Frontend::Users::ProfileController < Frontend::ApplicationController

  include UserUpdateProfileable

  def show
     load_user
  end

  private

  def user_params
    profile_attrs = [
      :avatar, :name, :birthday, :gender, :partner_name, :partner_birthday, :partner_email, :partner_mobile
    ]
    user_params = params[:user]
    user_params ? user_params.permit(:email, :mobile, :password, :password_confirmation, profile_attributes: profile_attrs) : {}
  end

  def update_success_redirect_to_url
    redirect_to users_profile_path
  end
end
