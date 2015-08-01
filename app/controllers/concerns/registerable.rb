module Registerable
  extend ActiveSupport::Concern
  included do
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  end

  def new
    build_user
  end

  def create
    build_user
    authorize @user, :create?
    save_user or render :new
  end

  private

  def user_scope
    raise NotImplementedError, 'Must be implemented by who mixins me.'
  end

  def build_user
    @user ||= user_scope.new(user_params)
  end

  def save_user
    # Example: redirect_to admin_users_path if @user.save
    raise NotImplementedError, 'Must be implemented by who mixins me.'
  end

  def user_params
    user_params = params[:user]
    infer = user_params ? user_params.permit(:email, :mobile, :password, :password_confirmation, :verification_code) : {}
    infer.merge(role: "member")
  end

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    error_msg = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
    @user.errors.add(:base, error_msg)
    render :new
  end

end
