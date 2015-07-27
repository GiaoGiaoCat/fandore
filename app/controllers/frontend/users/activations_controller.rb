class Frontend::Users::ActivationsController < Frontend::ApplicationController
  skip_before_action :authenticate_user!

  def new
    build_activation
  end

  def create
    build_activation
    save_activation or render 'new'
  end

  private

  def build_activation
    @activation ||= User::Activation.new(activation_params)
  end

  def save_activation
    if @activation.save
      session[:user_id] = @activation.user.id
      redirect_to root_path
    end
  end

  def activation_params
    user_params = params[:user_activation]
    user_params ? user_params.permit(:code) : { code: params[:code] }
  end
end
