module Lockable
  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods
  end

  def locked?
    last_pwd_failed_at.try(:today?) && pwd_failed_count > 5
  end

  def unlocked?
    !locked?
  end

  def increment_or_reset_pwd_failed_count!
    if last_pwd_failed_at.try(:today?)
      increment_pwd_failed_count!
    else
      reset_pwd_failed_count!
    end
  end


  private

  def increment_pwd_failed_count!
    increment!(:pwd_failed_count)
  end

  def reset_pwd_failed_count!
    update_columns(last_pwd_failed_at: Time.now, pwd_failed_count: 1)
  end
end
