class Frontend::Orders::CommentsController < Frontend::ApplicationController

  def new
    load_line_item
    build_comment
  end

  def create
    build_comment
    save_comment
  end

  private

  def load_line_item
    @line_item = current_user.line_items.find(params[:line_item_id])
  end

  def build_comment
    @comment ||= comment_scope.new
    @comment.attributes = comment_params
  end

  def save_comment
    @order.save
  end

  def comment_params
    comment_params = params[:comment]
    comment_params ? comment_params.permit(:sku, :price, :position) : {}
  end

  def comment_scope
    current_user.comments
  end

end
