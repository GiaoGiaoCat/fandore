module OrderStates
  extend ActiveSupport::Concern

  included do

    include AASM

    enum state: {
      pending: 0,
      paid: 10,
      filtered: 20,
      inlaided: 30,
      packed: 40,
      delivered: 50,
      completed: 60,
      canceled: 70,
      closed: 80,
      resumed: 90
    }

    aasm column: :state, enum: true do

      state :pending, initial: true
      state :paid
      state :filtered
      state :inlaided
      state :packed
      state :delivered
      state :completed
      state :canceled
      state :closed
      state :resumed

      event :pay, after: :notify_to_client do
        transitions form: :pending, to: :paid
      end

      event :filter, after: :notify_to_client do
        transitions form: :paid, to: :filtered
      end

      event :inlaid, after: :notify_to_client do
        transitions form: :filtered, to: :inlaided
      end

      event :pack, after: :notify_to_client do
        transitions form: :inlaided, to: :packed
      end

      event :delivery, after: :notify_to_client do
        transitions form: [:paid, :packed], to: :delivered, guard: :has_payment?
      end

      event :complete do
        transitions form: :delivery, to: :completed
      end

      event :cancel do
        transitions form: :pending, to: :canceled
      end

      event :closed do
        transitions form: [:pending, :completed], to: :closed
      end

      event :resume do
        # transitions form: :closed, to: :resumed
        transitions form: :closed, to: :pending
      end

    end

    # TODO: 这里需要验证订单确实已经付款过，拥有 payments
    def has_payment?
      true
    end

    # TODO: 这里需要给客户发送通知
    def notify_to_client
      true
    end

  end

  module ClassMethods
  end

  private
end
