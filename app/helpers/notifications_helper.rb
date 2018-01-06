module NotificationsHelper

  def posted_time(time)
    # 20YY-MM-DD 00:00:00のように表示される
    time > Date.today ? "#{time_ago_in_words(time)}" : time.strftime('%m月%d日')
  end
end
