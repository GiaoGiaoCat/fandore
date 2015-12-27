# generate error json for front-end api
module ActiveModel
  class Errors
    def to_formatted_json(as: nil, accepts_nested_attributes: false)
      hash = self.messages.each_with_object({}) do |(attribute, array), messages|
        # key = "field-#{as.to_s.presence || @base.model_name.singular}-#{attribute.to_s.gsub(/\./, '-')}"
        if accepts_nested_attributes
          key = "#{as.to_s.presence || @base.model_name.singular}[#{attribute.to_s.gsub(/\./, '_attributes][')}]"
        else
          key = "#{as.to_s.presence || @base.model_name.singular}[#{attribute.to_s.gsub(/\./, '-')}]"
        end
        messages[key] = array
      end
      hash.to_json.html_safe
    end
  end
end
