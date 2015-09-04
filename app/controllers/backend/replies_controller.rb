class Backend::RepliesController < Backend::ApplicationController

  before_action :load_comment

  def index
    load_replies
  end

  def new
    build_reply
  end

  def create
    build_reply
    save_reply or render 'new'
  end

  def edit
    load_reply
    build_reply
  end

  def update
    load_reply
    build_reply
    update_reply or render 'edit'
  end


  def destroy
    load_reply
    @reply.destroy
    redirect_to admin_comments_path
  end

  private

  def load_comment
    @comment ||= Comment.find(params[:comment_id])
  end

  def load_replies
    @replies ||= @comment.comments
  end

  def load_reply
    @reply ||= @comment.comments.find(params[:id])
  end

  def build_reply
    @reply ||= reply_scope.build(user: current_user)
    @reply.attributes = reply_params
  end

  def save_reply
    redirect_to admin_comments_path if @reply.save
  end

  def reply_params
    reply_params = params[:comment]
    reply_params ? reply_params.permit(:title, :comment) : {}
  end

  def reply_scope
    @comment.comments
  end

end
