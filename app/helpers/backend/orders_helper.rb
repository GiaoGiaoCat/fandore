module Backend::OrdersHelper
  def show_shipping_address(address)
    "#{address.address}, #{address.name}, #{address.mobile}"
  end
end
