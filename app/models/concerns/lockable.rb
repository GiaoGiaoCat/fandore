module Lockable
  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods
  end

  def locked?
    last_failed_sign_in_at.try(:today?) && failed_sign_in_count > 4
  end

  def unlocked?
    !locked?
  end

  def unlock!
    reset_failed_sign_in_count!
  end

  def should_unlock?
    !last_failed_sign_in_at.try(:today?)
  end

  def increment_or_reset_failed_sign_in_count!
    should_unlock? ? reset_failed_sign_in_count! : increment_failed_sign_in_count!
  end


  private

  def increment_failed_sign_in_count!
    increment!(:failed_sign_in_count)
  end

  def reset_failed_sign_in_count!
    update_columns(last_failed_sign_in_at: Time.now, failed_sign_in_count: 0)
  end
end
