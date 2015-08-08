class Frontend::Users::SafetyQuestionsController < Frontend::ApplicationController

  include UserUpdateProfileable

  private

  def user_params
    user_params = params[:user]
    user_params ? user_params.permit(profile_attributes: [:question, :answer]) : {}
  end

  def update_success_redirect_to_url
    redirect_to account_safe_path
  end

end
