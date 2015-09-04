module Backend::RepliesHelper
  def dynamic_url_for_reply(comment, reply)
    if reply.new_record?
      admin_comment_replies_path(comment)
    else
      admin_comment_reply_path(comment, reply)
    end
  end
end
