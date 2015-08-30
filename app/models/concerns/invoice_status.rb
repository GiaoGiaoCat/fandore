module InvoiceStatus
  extend ActiveSupport::Concern

  included do

    include AASM

    #TODO 这里需要完成具体逻辑或者状态机
    enum status: {
      paid: 0,
      cancelled: 10,
      unpaid: 20,
      collection: 30,
      invoice_sent: 40,
      amount_sent: 50,
      amount_received: 60,
    }

    aasm column: :status do
      state :unpaid, initial: true
      state :paid
      state :collection
      state :invoice_sent
      state :cancelled
      state :amount_received
      state :amount_sent
    end
  end
end

      # event :, after: :update_totals do
      #   transitions from: :checkout, to: :pending
      # end

      # event :pay, after: :notify_to_client do
      #   transitions from: :pending, to: :paid
      # end

      # event :filter, after: :notify_to_client do
      #   transitions from: :paid, to: :filtered
      # end

      # event :inlaid, after: :notify_to_client do
      #   transitions from: :filtered, to: :inlaided
      # end

      # event :pack, after: :notify_to_client do
      #   transitions from: :inlaided, to: :packed
      # end

      # event :delivery, after: :notify_to_client do
      #   transitions from: [:paid, :packed], to: :delivered, guard: :has_payment?
      # end

      # event :complete do
      #   transitions from: :delivery, to: :completed
      # end

      # event :cancel do
      #   transitions from: :pending, to: :canceled
      # end

      # event :closed do
      #   transitions from: [:pending, :completed], to: :closed
      # end

      # event :resume do
      #   # transitions from: :closed, to: :resumed
      #   transitions from: :closed, to: :pending
      # end

