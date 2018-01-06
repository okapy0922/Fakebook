class RelationshipsController < ApplicationController
  before_action :authenticate_user! # コントローラーの先頭に記載するヘルパーメソッド。行われる処理はログインユーザーによってのみ実行可能
  respond_to :js

  def create
    # @user = User.find(params[:relationship][:followed_id])で送られてきたパラメータを元に、フォローしたいユーザを取得
    @user = User.find(params[:relationship][:followed_id])
    # current_user.follow!(@user)でそのユーザをフォロー
    current_user.follow!(@user)
    respond_with @user
  end

  def destroy
    # @user = Reletioship.find(params[:id).followedで送られてきたパラメータを元に、フォロー解除したいユーザを取得
    @user = Relationship.find(params[:id]).followed
    # current_user.unfollow!(@user)でそのユーザをフォロー解除する
    current_user.unfollow!(@user)
    respond_with @user
  end
end
