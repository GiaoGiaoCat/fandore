module OrderStates
  extend ActiveSupport::Concern

  included do

    include AASM
    include OrderUpdater

    enum state: {
      checkout: 0,
      # addressed: 2,
      # invoiced: 4,
      # shipmented: 6,
      processing: 10,
      pending: 20,
      paid: 30,
      filtered: 40,
      inlaided: 50,
      quality_checked: 55,
      packed: 60,
      delivered: 70,
      completed: 80,
      canceled: 90,
      closed: 93,
      refunded: 95,
      resumed: 100
    }

    aasm column: :state, enum: true do

      state :checkout, initial: true
      state :processing
      state :pending
      state :paid
      state :filtered
      state :inlaided
      state :quality_checked
      state :packed
      state :delivered
      state :completed
      state :canceled
      state :closed
      state :refunded
      state :resumed

      event :started_processing, after: :update_totals do
        transitions from: [:checkout, :pending, :completed, :processing], to: :processing
      end

      event :pend, after: [:update_totals, :initialize_payment] do
        transitions from: [:checkout, :processing], to: :pending
      end

      event :pay, after: :notify_to_client do
        transitions from: :pending, to: :paid
      end

      event :filter, after: :notify_to_client do
        transitions from: :paid, to: :filtered
      end

      event :inlaid, after: :notify_to_client do
        transitions from: :filtered, to: :inlaided
      end

      event :quality_check do
        transitions from: :inlaided, to: :quality_checked
      end

      event :pack, after: :notify_to_client do
        transitions from: :quality_checked, to: :packed
      end

      event :delivery, after: :notify_to_client do
        transitions from: [:paid, :packed], to: :delivered, guard: :has_payment?
      end

      event :complete do
        transitions from: :delivered, to: :completed
      end

      event :cancel do
        transitions from: :pending, to: :canceled
      end

      event :close do
        transitions from: [:checkout, :pending], to: :closed
      end

      event :refund do
        transitions from: [:completed], to: :refunded
      end

      event :resume do
        # transitions from: :closed, to: :resumed
        transitions from: :closed, to: :pending
      end

    end

    # NOTE: 当用户点击付款，生成一条付款记录，目前每条订单对应一条支付记录
    def initialize_payment
      payment_method = Payment::PaymentMethod.find_by(name: self.payment_method)
      payments.first_or_create(payment_method_id: payment_method.id)
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
