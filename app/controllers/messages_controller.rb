class MessagesController < ApplicationController
# 全ユーザ間の会話の処理は共通で処理しますの定義
before_action do
  @conversation = Conversation.find(params[:conversation_id])
end
# 今まで会話したユーザのメッセージ一覧
def index
  # 会話に紐づくメッセージを取得
  @messages = @conversation.messages
  # もしメッセージの数が10よりも大きければ、10より大きいというフラグを有効にしてメッセージを最新の10に絞り表示する
  if @messages.length > 10
    @over_ten = true
    @messages = @messages[-10..-1]
  end
  # 10以下のパターンは10より大きいというフラグを無効にして、会話にひもづくメッセージをすべて取得する
  if params[:m]
    @over_ten = false
    @messages = @conversation.messages
  end
  # 最後のメッセージが、ユーザIDが自分（ログインユーザ）でなければ、そのメッセージを既読にする
  # lastメソッドは、配列の最後の要素を返し空のときはnilを返す、というRubyのメソッド http://ref.xaio.jp/ruby/classes/array/last
  if @messages.last
    if @messages.last.user_id != current_user.id
      @messages.last.read = true
    end
  end
  # 新規投稿のメッセージ用の変数を作成する
  @message = @conversation.messages.build
end

def create
  # HTTPリクエスト上のパラメータを利用して会話にひもづくメッセージを生成
  @message = @conversation.messages.build(message_params)
  # メッセージを保存した処理のあと、会話にひもづくメッセージ一覧の画面に遷移する
  if @message.save
    redirect_to conversation_messages_path(@conversation)
  end
end

private
  # ストロングパラメーター、画面上のメッセージの内容「body」や投稿者のID(user_id)を安全に取得する
  def message_params
    params.require(:message).permit(:body, :user_id)
  end

end
