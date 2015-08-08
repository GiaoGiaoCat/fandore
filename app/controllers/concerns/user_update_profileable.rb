module UserUpdateProfileable
  extend ActiveSupport::Concern

  def edit
    load_user
  end

  def update
    load_user
    update_user_profile or render 'edit'
  end

  private

  def load_user
    @user = current_user
  end

  def update_user_profile
    if @user.update_attributes user_params
      update_success_redirect_to_url
    end
  end

  def user_params
    raise NotImplementedError, 'please define you self user_params'
  end

  def update_success_redirect_to_url
    raise NotImplementedError, 'please define you self user_params'
  end

end
