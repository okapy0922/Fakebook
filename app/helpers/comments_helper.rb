module CommentsHelper
  def choose_create_or_update
    if action_name == 'new'
      topics_path
    elsif action_name == 'edit'
      topic_path
    end
  end
end
