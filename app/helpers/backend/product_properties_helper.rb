module Backend::ProductPropertiesHelper
  def dynamic_input(f, label = nil)
    case f.object.property_name
    # 以下戒托属性
    when 'Sub Stone Style'
      dynamic_collection_select(f, ['单钻', '侧钻', '群镶'], label)
    when 'Sub Stone Color'
      dynamic_collection_select(f, ['白钻', '粉钻', '黄钻'], label)

    # 以下钻石属性
    when 'Shape'
      dynamic_collection_select(f, ['圆型', '心型', '公主方', '梨型'], label)
    when 'Color'
      dynamic_collection_select(f, ['D', 'E', 'F', 'G', 'H', 'I'], label)
    when 'Stock'
      dynamic_collection_select(f, ['HK', 'SZ'], label)
    when 'Certificate'
      dynamic_collection_select(f, ['GIA'], label)
    when 'Culet'
      dynamic_collection_select(f, ['None', 'Very Small', 'Small'], label)
    when 'Girdle Thickness'
      dynamic_collection_select(f, ['Thin to Medium', 'Medium', 'Medium to Slightly Thick'], label)
    when 'Fluorescence'
      dynamic_collection_select(f, ['None', 'Faint', 'Medium Blue', 'Medium Yellow', 'Strong Blue', 'Strong Yellow'], label)
    when 'Polish'
      dynamic_collection_select(f, ['EX', 'VG', 'GD'], label)
    when 'Cut'
      dynamic_collection_select(f, ['EX', 'VG', 'GD'], label)
    when 'Symmetry'
      dynamic_collection_select(f, ['EX', 'VG', 'GD'], label)
    when 'Clarity'
      dynamic_collection_select(f, ['IF', 'FL', 'VVS1', 'VVS2', 'VS1', 'VS2', 'SI1', 'SI2'], label)
    else
      f.input :value, wrapper: :nested_fields, label: label
    end
  end

  def dynamic_collection_select(f, collections, label = nil)
    f.input :value, collection: collections, include_blank: false, wrapper: :nested_fields, label: label
  end

  def dynamic_collection_multiple_select(f, collections)
    f.input :value, collection: collections, include_blank: false, input_html: { multiple: true }, prompt: "Select Property", wrapper: :nested_fields
  end

end
