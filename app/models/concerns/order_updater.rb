module OrderUpdater
  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods
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
    update_item_total
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
