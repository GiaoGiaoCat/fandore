module Backend::VariantsHelper
  # How to use:
  # = f.input :status, collection: t_options_for_select(Product::Variant, :status)
  #
  # NOTE: remember to add I18N at config/enumerize.yml
  # Example:
  # zh:
  #   enumerize:
  #     user:
  #       gender:
  #         male: "男"
  #         female: "女"
  def t_options_for_select(class_obj, enums_name)
    enums = class_obj.send(enums_name.to_s.pluralize)
    enums.keys.map {|enum| t_enum_option_for_select(enum, class_obj.name.underscore.to_sym, enums_name) }
  end

  def t_enum_option_for_select(enum, class_name, enum_name)
    [t(enum, scope: [:enumerize, class_name, enum_name]), enum]
  end
end
