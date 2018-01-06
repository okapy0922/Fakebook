class ConversationsController < ApplicationController
  # ログインした状態のみ操作ができる
  before_action :authenticate_user!

  def index
    # 会話した相手との今までのやり取りを全部取得し一覧表示する。LINEの会話履歴できな
    @users = User.all
    @conversations = Conversation.all
  end

  def create
    # 新たな会話を作成するcreate、senderが送り主でrecipientが受取人
    # 該当のユーザ間での会話が過去に存在しているかを確認するif文
    if Conversation.between(params[:sender_id], params[:recipient_id]).present?
      # 存在したときその会話を取得する
      @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
    else
      # もし過去にやり取りしたことがなかったらメッセージを生成します。この時、HTTPリクエストに含まれるパラメータを利用して会話を生成
      @conversation = Conversation.create!(conversation_params)
    end
    # メッセージの一覧画面へ遷移する
    redirect_to conversation_messages_path(@conversation)
  end


  private
  # ストロングパラメーター、「conversasion_params」sender_idとrecipient_idを入れることで送り主と受取人を取得していく
  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end

end
