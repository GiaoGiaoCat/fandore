module Frontend::ProductsHelper
  def products_nav(en_text, cn_text, taxon, active_taxon)
    # link_to_unless_current(content_tag(:i, nil, class: 'dot-circle') + content_tag(:em, en_text, class: 'font-eng') + "#{ cn_text}", products_path(taxon_name: taxon_name)) do
    #   link_to(content_tag(:i, nil, class: 'dot-circle') + content_tag(:em, en_text, class: 'font-eng') + "#{ cn_text}", products_path(taxon_name: taxon_name), class: 'active')
    # end
    class_name = (taxon == active_taxon ? 'active' : nil)
    link_to(content_tag(:i, nil, class: 'dot-circle') + content_tag(:em, en_text, class: 'font-eng') + cn_text, products_path(taxon_name: taxon), class: class_name)
  end
end
