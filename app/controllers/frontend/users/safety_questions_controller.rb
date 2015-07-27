class Frontend::Users::SafetyQuestionsController < Frontend::ApplicationController
  layout 'empty'

  def new
    is_set_question
    @question = question_scope
  end

  def create
    build_question
    save_question_answer or render "new"
  end


  private

  def user_params
    user_params = params[:user_profile]
    user_params ? user_params.permit(:question, :answer) : {}
  end

  def save_question_answer
    redirect_to account_safe_path if (current_user.profile.question.length > 0 && current_user.profile.question.length > 0)
  end

  def build_question
    @question_answer = question_scope.update(user_params)
  end

  def is_set_question
     redirect_to account_safe_path if current_user.profile.question && current_user.profile.question
  end

  def question_scope
    current_user.profile
  end

end
