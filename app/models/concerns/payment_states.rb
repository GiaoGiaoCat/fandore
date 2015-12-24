module PaymentStates
  extend ActiveSupport::Concern

  included do

    include AASM

    enum state: {
      checkout: 0,
      pending: 10,
      completed: 20,
      processing: 30,
      void: 40,
      failed: 50,
      # invalid: 60,
    }


    aasm column: :state, enum: true do

      state :checkout, initial: true
      state :pending
      state :completed
      state :processing
      state :void
      state :failed
      # state :invalid

      event :started_processing do
        transitions from: [:checkout, :pending, :completed, :processing], to: :processing
      end

      # When processing during checkout fails
      event :failure do
        transitions from: [:pending, :processing], to: :failed
      end

      # With card payments this represents authorizing the payment
      event :pend do
        transitions from: [:checkout, :processing], to: :pending
      end

      # With card payments this represents completing a purchase or capture transaction
      event :complete do
        transitions from: [:processing, :pending, :checkout], to: :completed
      end

      event :void do
        transitions from: [:pending, :processing, :completed, :checkout], to: :void
      end
      
      # NOTE: "invalid?", which is already defined by Active Record.
      # when the card brand isnt supported
      # event :invalidate do
      #   transitions from: [:checkout], to: :invalid
      # end

    end

  end

  module ClassMethods
  end

  private
end
