module Registerable
  extend ActiveSupport::Concern

  def new
    build_user
  end

  def create
    build_user

    respond_to do |format|
      if save_user
        format.html { redirect_to_url, notice: 'User was successfully sign up.' }
        format.js
      else
        format.html { render :new }
        format.js
      end
    end
  end

  private

  def user_scope
    raise NotImplementedError, 'Must be implemented by who mixins me.'
  end

  def build_user
    @user ||= user_scope.new(user_params)
  end

  def save_user
    raise NotImplementedError, 'Must be implemented by who mixins me.'
  end

  def redirect_to_url
    raise NotImplementedError, 'Must be implemented by who mixins me.'
  end

  def user_params
    user_params = params[:user]
    user_params ? user_params.permit(:email, :mobile, :password, :password_confirmation, :verification_code) : {}
  end
end
