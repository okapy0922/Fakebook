class UsersController < ApplicationController
  def index
    # 19_フォロー機能 で編集
    # 下記を挿入　indexメソッドでuserを全て取得する
    @users = User.all
  end

  # 19_フォロー機能 課題
  # showアクションの定義
  def show
    @user = User.find(params[:id])
    @user_followed = @user.followed_users #フォローしている人を取得
    @user_followers = @user.followers #フォロワーを取得
    # コントローラの変数@userとビューの変数@userは同じじゃないとNomethodErrorとなる
  end
end
