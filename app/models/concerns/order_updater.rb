module OrderUpdater
  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods
  end

  def initial_totals
    update_totals
    save
  end

  # Updates the following Order total values:
  #
  # +payment_total+      The total value of all finalized Payments (NOTE: non-finalized Payments are excluded)
  # +item_total+         The total value of all LineItems
  # +adjustment_total+   The total value of all adjustments (promotions, credits, etc.)
  # +promo_total+        The total value of all promotion adjustments
  # +total+              The so-called "order total."  This is equivalent to +item_total+ plus +adjustment_total+.
  def update_totals
    # update_payment_total
    if self.is_try_before_buy?
      self.item_total = 300
      self.total = 300
    else
      update_item_total
    end
    # update_shipment_total
    # update_adjustment_total
  end

  private

  def update_item_total
    self.item_total = line_items.sum('price * quantity')
    update_order_total
  end

  def update_order_total
    self.total = item_total + shipment_total + adjustment_total
  end
end
