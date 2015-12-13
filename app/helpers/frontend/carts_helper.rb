module Frontend::CartsHelper
  def show_diamond_info(item)
    return unless item
    product_name = item.product.name
    names = product_name.split("-")
    "克拉总重量：#{names[0]}, #{names[1]} 成色, #{names[2]} 净度"
  end

  def show_certificate_no(item)
    return unless item
    certificate_no = Product::Property.find_by(name: 'Certificate No')
    certificate_no_value = item.line_items_properties.find_by(property_id: certificate_no.id).value
    "证书编号：#{certificate_no_value}"
  end

  def show_properties(item)
    return unless item
    size = Product::Property.find_by(name: 'Size')
    lettering = Product::Property.find_by(name: 'Lettering')
    size_value = item.line_items_properties.find_by(property_id: size.id).value
    lettering_value = item.line_items_properties.find_by(property_id: lettering.id).value
    "手寸：#{size_value}, 刻字：#{lettering_value}"
  end
end
