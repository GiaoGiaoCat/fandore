module Backend::ProductPropertiesHelper
  def dynamic_input(f)
    case f.object.property_name
    when 'Sub Stone Style'
      dynamic_collection_input(f, ['单钻', '侧钻', '群镶'])
    when 'Sub Stone Color'
      dynamic_collection_input(f, ['白钻', '粉钻', '黄钻'])
    else
      f.input :value, wrapper: :nested_fields
    end
  end

  def dynamic_collection_input(f, collections)
    f.input :value, collection: collections, include_blank: false, prompt: "Select Property", wrapper: :nested_fields
  end
end
