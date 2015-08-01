class Frontend::Users::QuestionsController < Frontend::ApplicationController
  skip_before_action :authenticate_user!
  def new
    build_question
  end

  def create
    load_user
    if @user
      redirect_to users_questions_edit_path(question_params) 
    else 
      redirect_to users_questions_new_path
    end
  end

  def edit
    build_question
    load_user
  end

  def update
    load_user
    if User::Question.is_answer(@user,answer_params[:answer])
      redirect_to new_password_path(email: @user.email, answer: @user.profile.answer)
    else
      redirect_to users_questions_edit_path(question_params)
    end
  end

  private

  def load_user
    @user = User.find_by(question_params)
  end

  def build_question
    @question = question_scope.new
  end

  def question_scope
    User::Question
  end

  def question_params
    question_params = params[:user_question]
    question_params ? question_params.permit(:email) : {}
  end

  def build_answer
  end

  def answer_params
    answer_params = params[:user_question]
    answer_params ? answer_params.permit(:answer) : {}
  end

end