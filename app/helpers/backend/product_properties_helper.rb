module Backend::ProductPropertiesHelper
  def dynamic_input(f)
    case f.object.property_name
    # 以下戒托属性
    when 'Sub Stone Style'
      dynamic_collection_select(f, ['单钻', '侧钻', '群镶'])
    when 'Sub Stone Color'
      dynamic_collection_select(f, ['白钻', '粉钻', '黄钻'])

    # 以下钻石属性
    when 'Shape'
      dynamic_collection_select(f, ['圆型', '心型', '公主方', '梨型'])
    when 'Color'
      dynamic_collection_select(f, ['D', 'E', 'F', 'G', 'H', 'I'])
    when 'Stock'
      dynamic_collection_select(f, ['HK', 'SZ'])
    when 'Certificate'
      dynamic_collection_select(f, ['GIA'])
    when 'Culet'
      dynamic_collection_select(f, ['None', 'Very Small', 'Small'])
    when 'Girdle Thickness'
      dynamic_collection_select(f, ['Thin to Medium', 'Medium', 'Medium to Slightly Thick'])
    when 'Fluorescence'
      dynamic_collection_select(f, ['None', 'Faint', 'Medium Blue', 'Medium Yellow', 'Strong Blue', 'Strong Yellow'])
    when 'Polish'
      dynamic_collection_select(f, ['EX', 'VG', 'GD'])
    when 'Cut'
      dynamic_collection_select(f, ['EX', 'VG', 'GD'])
    when 'Symmetry'
      dynamic_collection_select(f, ['EX', 'VG', 'GD'])
    when 'Clarity'
      dynamic_collection_select(f, ['FL', 'VVS1', 'VVS2', 'VS1', 'VS2', 'SI1', 'SI2'])
    else
      f.input :value, wrapper: :nested_fields
    end
  end

  def dynamic_collection_select(f, collections)
    f.input :value, collection: collections, include_blank: false, wrapper: :nested_fields
  end

  def dynamic_collection_multiple_select(f, collections)
    f.input :value, collection: collections, include_blank: false, input_html: { multiple: true }, prompt: "Select Property", wrapper: :nested_fields
  end

end
