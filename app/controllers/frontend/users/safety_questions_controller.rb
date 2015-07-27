class Frontend::Users::SafetyQuestionsController < Frontend::ApplicationController

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
      redirect_to account_safe_path
    end
  end

  def user_params
    user_params = params[:user]
    user_params ? user_params.permit(profile_attributes: [:question, :question]) : {}
  end

end
