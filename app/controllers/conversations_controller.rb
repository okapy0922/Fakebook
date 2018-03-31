class ConversationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all
    @conversations = Conversation.all
  end

  def create
    # 対象とするユーザ間の会話が過去にあったか?
    if Conversation.between(params[:sender_id], params[:recipient_id]).present?
      # 会話が過去にあった場合その会話情報を取得する
      @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
    else
      # 会話が一見も存在しない場合メッセージを生成する
      @conversation = Conversation.create!(conversation_params)
    end

    redirect_to conversation_messages_path(@conversation)
  end

  private
  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
end
