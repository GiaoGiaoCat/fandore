class Backend::UsersController < Backend::ApplicationController
  include Registerable

  skip_before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @q = user_scope.ransack(params[:q])
    @users = @q.result
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, flash: { success: 'Successfully updated.' }
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, flash: { success: 'Successfully destroyed.' }
  end

  private

  def user_scope
    User
  end

  def set_user
    @user = user_scope.find(params[:id])
  end

  def save_user
    redirect_to admin_users_path if @user.save
  end

  def user_params
    profile_attrs = [
      :avatar, :name, :birthday, :gender, :partner_name, :partner_birthday, :partner_email, :partner_mobile
    ]
    user_params = params[:user]
    user_params ? user_params.permit(:email, :mobile, :password, :password_confirmation, profile_attributes: profile_attrs) : {}
  end
end
