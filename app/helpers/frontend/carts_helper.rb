module Frontend::CartsHelper
  def show_diamond_info(item)
    return unless item
    carat = Product::Property.find_by(name: 'Carat')
    color = Product::Property.find_by(name: 'Color')
    clarity = Product::Property.find_by(name: 'Clarity')
    carat_value = item.product.product_properties.find_by(property_id: carat.id).value
    color_value = item.product.product_properties.find_by(property_id: color.id).value
    clarity_value = item.product.product_properties.find_by(property_id: clarity.id).value
    "主钻：#{carat_value}/#{color_value}/#{clarity_value}/3EX"
  end

  def show_certificate_no(item)
    return unless item
    certificate_no = Product::Property.find_by(name: 'GIA Report Number')
    certificate_no_value = item.line_items_properties.find_by(property_id: certificate_no.id).value
    "证书编号：#{certificate_no_value}"
  end

  def show_properties(item)
    return unless item
    if item.is_wedding?
      m_size = Product::Property.find_by(name: 'Male Size')
      m_lettering = Product::Property.find_by(name: 'Male Lettering')
      m_size_value = item.line_items_properties.find_by(property_id: m_size.id).try(:value)
      m_lettering_value = item.line_items_properties.find_by(property_id: m_lettering.id).try(:value)
      m_text = "男款手寸：#{m_size_value}, 刻字：#{m_lettering_value}"

      f_size = Product::Property.find_by(name: 'Female Size')
      f_lettering = Product::Property.find_by(name: 'Female Lettering')
      f_size_value = item.line_items_properties.find_by(property_id: f_size.id).try(:value)
      f_lettering_value = item.line_items_properties.find_by(property_id: f_lettering.id).try(:value)
      f_text = "女款手寸：#{f_size_value}, 刻字：#{f_lettering_value}"
      [m_text, f_text].join(' ')
    elsif item.is_engaement?
      size = Product::Property.find_by(name: 'Size')
      lettering = Product::Property.find_by(name: 'Lettering')
      size_value = item.line_items_properties.find_by(property_id: size.id).value
      lettering_value = item.line_items_properties.find_by(property_id: lettering.id).value
      "手寸：#{size_value}, 刻字：#{lettering_value}"
    end
  end
end
