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
    up_user
  end

private

  def load_user
    @user = current_user
  end

  def up_user
    current_user.update(user_params)
    redirect_to action: :show
  end

  def user_params
    user_params = params[:user]
    user_params ? user_params.permit(:name, :avatar, :gender, :birthday) : {}
  end
end
