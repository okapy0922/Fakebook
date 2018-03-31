class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index
    # 会話に紐づくメッセージを取得する
    @messages = @conversation.messages
    # もしメッセージが最後のメッセージで、かつユーザIDが自分でなければ、その最後のメッセージを既読にする
    if @messages.last
      if @messages.last.user_id != current_user.id
        @messages.last.read = true
      end
    end
    # 新規投稿のメッセージの変数を作成する
    @message = @conversation.messages.build
  end

  def create
    # HTTPリクエストのパラメータを利用し、会話に紐づくメッセージを生成
    @message = @conversation.messages.build(message_params)
      # 保存ができたら会話に紐づくメッセージ一覧画面に遷移
      if @message.save
        redirect_to conversation_messages_path(@conversation)
      end
  end

# message_params のストロングパラメータ定義
private
  def message_params
    params.require(:message).permit(:body, :user_id)
  end

end
