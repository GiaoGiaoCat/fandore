class Frontend::Users::ProfileController < Frontend::ApplicationController
  layout 'empty'

  def show
     load_user
  end

  def edit
    load_user
  end

  def update
    load_user
    build_user
    save_user or render 'edit'
  end

  private

  def load_user
    @user = current_user
  end

  def build_user
    @user.attributes = user_params
  end

  def save_user
    if @user.save
      redirect_to users_profile_path
    end
  end

  def user_params
    profile_attrs = [
      :avatar, :name, :birthday, :gender, :partner_name, :partner_birthday, :partner_email, :partner_mobile
    ]
    user_params = params[:user]
    user_params ? user_params.permit(:email, :mobile, :password, :password_confirmation, profile_attributes: profile_attrs) : {}
  end
end
