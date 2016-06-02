module Frontend::ProductsHelper
  def products_nav(en_text, cn_text, taxon, active_taxon)
    # link_to_unless_current(content_tag(:i, nil, class: 'dot-circle') + content_tag(:em, en_text, class: 'font-eng') + "#{ cn_text}", products_path(taxon_name: taxon_name)) do
    #   link_to(content_tag(:i, nil, class: 'dot-circle') + content_tag(:em, en_text, class: 'font-eng') + "#{ cn_text}", products_path(taxon_name: taxon_name), class: 'active')
    # end
    class_name = (taxon == active_taxon ? 'active' : nil)
    link_to(content_tag(:i, nil, class: 'dot-circle') + content_tag(:em, en_text, class: 'font-eng') + cn_text, products_path(taxon_name: taxon), class: class_name)
  end

  def add_to_cart_button(p)
    btn_class = 'btn btn-default btn-lg btn-shopping btn-normal-buy'
    button_tag(type: 'submit', disabled: p.unavailable?, class: btn_class, data: { disable_with: '正在提交...'}) do
      content_tag(:span, nil, class: 'glyphicon glyphicon-shopping-cart') + '加入购物车'
    end
  end

  def add_try_before_buy_to_cart_button(p)
    btn_class = 'btn btn-default btn-lg btn-shopping btn-try-before-buy'
    button_tag(type: 'submit', disabled: p.unavailable?, class: btn_class, data: { disable_with: '正在提交...'}) do
      content_tag(:input, nil, type: 'hidden', name: 'is_try_before_buy', id: 'is_try_before_buy') do 
        content_tag(:span, nil, class: 'glyphicon glyphicon-shopping-cart') + '加入试戴'
      end
    end
  end
end
