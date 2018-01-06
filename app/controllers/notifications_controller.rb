class NotificationsController < ApplicationController
  # コントローラーの先頭に記載するヘルパーメソッド。行われる処理はログインユーザーによってのみ実行可能
  before_action :authenticate_user!
    def index
    # .where(read: false)で、未読の通知のみ表示
    @notifications = Notification.where(user_id: current_user.id).where(read: false).order(created_at: :desc)
    end
end
