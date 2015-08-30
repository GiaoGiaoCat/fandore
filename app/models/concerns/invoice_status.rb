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
