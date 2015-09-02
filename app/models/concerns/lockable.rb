module Lockable
  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods
  end

  def locked?
    last_pwd_failed_at.try(:today?) && pwd_failed_count > 4
  end

  def unlocked?
    !locked?
  end

  def unlock!
    reset_pwd_failed_count!
  end

  def should_unlocked?
    !last_pwd_failed_at.try(:today?)
  end

  def increment_or_reset_pwd_failed_count!
    should_unlocked? ? reset_pwd_failed_count! : increment_pwd_failed_count!
  end


  private

  def increment_pwd_failed_count!
    increment!(:pwd_failed_count)
  end

  def reset_pwd_failed_count!
    update_columns(last_pwd_failed_at: Time.now, pwd_failed_count: 0)
  end
end
