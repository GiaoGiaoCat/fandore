module Frontend::CartsHelper
  def show_diamond_info(item)
    product_name = item.product.name
    names = product_name.split("-")
    "克拉总重量：#{names[0]} 成色：#{names[1]} 净度：#{names[2]} "
  end
end
