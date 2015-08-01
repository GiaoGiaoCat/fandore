class UserPolicy < ApplicationPolicy

  def initialize(user, update_user)
    @user, @update_user = user, update_user
    super
  end

  def create?
    #here @user is nil, for user hasn't login
    !@update_user.admin?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
