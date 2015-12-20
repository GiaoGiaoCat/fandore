# generate error json for front-end api
module ActiveModel
  class Errors
    def to_formatted_json(as: nil)
      hash = self.messages.each_with_object({}) do |(attribute, array), messages|
        # key = "field-#{as.to_s.presence || @base.model_name.singular}-#{attribute.to_s.gsub(/\./, '-')}"
        key = "#{as.to_s.presence || @base.model_name.singular}[#{attribute.to_s.gsub(/\./, '-')}]"
        messages[key] = array
      end
      hash.to_json.html_safe
    end
  end
end
