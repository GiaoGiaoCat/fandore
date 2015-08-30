class Frontend::Orders::CommentsController < Frontend::ApplicationController

  before_action :load_line_item, :build_comment, only: [:new, :create]

  def new
  end

  def create
    save_comment or render 'new'
  end

  def show
    @comment = Comment.find(params[:id])
    render 'show'
  end

  private

  def load_line_item
    @line_item = current_user.line_items.find(params[:line_item_id])
  end

  def build_comment
    @comment ||= comment_scope.build(user: current_user)
    @comment.attributes = comment_params
  end

  def save_comment
    if @comment.save
      # redirect_to order_path(@line_item.order)
      redirect_to comment_path(@comment)
    end
  end

  def comment_params
    comment_params = params[:comment]
    comment_params ? comment_params.permit(:title, :comment, { pictures: [] }) : {}
  end

  def comment_scope
    @line_item.comments
  end

end
