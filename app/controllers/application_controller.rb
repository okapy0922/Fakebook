class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  # ログインしている時のみ、current_notificationsメソッドが起動する
  before_action :current_notifications, if: :signed_in?
  # ヘッダーに未読の通知件数を表示させる
  def current_notifications
    @notifications_count = Notification.where(user_id: current_user.id).where(read: false).count
  end

  protect_from_forgery with: :exception
  # before_actionで下で定義したメソッドを実行
  before_action :configure_permitted_parameters, if: :devise_controller?
  #変数PERMISSIBLE_ATTRIBUTESに配列[:name avatar avatar_cache]を代入
  PERMISSIBLE_ATTRIBUTES = %i(name avatar avatar_cache)

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, :alert => exception.message
  end

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: PERMISSIBLE_ATTRIBUTES)
    devise_parameter_sanitizer.permit(:account_update, keys: PERMISSIBLE_ATTRIBUTES)
  end
end
