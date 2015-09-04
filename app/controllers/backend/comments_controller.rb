class Backend::CommentsController < Backend::ApplicationController

  before_action :load_comment, only: [:show, :edit, :update, :destroy]


  def index
    load_comments
  end

  def show
    load_comment
  end

  def new
    build_comment
  end

  def create
    build_comment
    save_comment or render 'new'
  end

  def edit
    load_comment
    build_comment
  end

  def update
    load_comment
    build_comment
    update_comment or render 'edit'
  end

  def destroy
    load_comment
    @comment.destroy
    redirect_to admin_comments_path
  end

  private

  def load_comments
    # XXX: https://github.com/activerecord-hackery/ransack/wiki/Using-Ransackers
    # 下面的代码很丑陋，可以参考上面的链接重构
    @comments ||= Comment.search_by_keyword(params[:q]).page params[:page]
  end

  def load_comment
    @comment ||= comment_scope.find(params[:id])
  end

  def build_comment
    @comment ||= comment_scope.new
    @comment.attributes = comment_params
  end

  def save_comment
    redirect_to admin_comments_path if @comment.save
  end

  def update_comment
    redirect_to admin_comments_path if @comment.save
  end

  def comment_params
    comment_params = params[:comment]
    comment_params ? comment_params.permit(:title, :comment) : {}
  end

  def comment_scope
    Comment
  end
end
