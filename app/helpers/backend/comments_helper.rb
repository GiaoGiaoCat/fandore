module Backend::CommentsHelper
  def show_reply_status(replied)
    if replied
      content_tag(:span, '已回复', class: 'label label-primary')
    else
      content_tag(:span, '未回复', class: 'label')
    end
  end
end
