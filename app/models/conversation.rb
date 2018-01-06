class Conversation < ActiveRecord::Base
# 会話の送り主がユーザモデルから参照できるようにアソシエーションを設定
# Userモデルのモデル名にidをつけただけのカラムではないのでclassnameを明示的に指定する
belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
# 会話の受取人がユーザモデルから参照できるようにアソシエーションを設定
# Userモデルのモデル名にidをつけただけのカラムではないのでclassnameを明示的に指定する
belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'
# 会話は複数のメッセージを保有し、会話が削除されたらメッセージも削除する
has_many :messages, dependent: :destroy
# 送り主と受取人が重複しないよう制御しチェックする validates_uniqueness_of(検証するフィールド名 [, オプション]) は、属性の値が一意であることを検証するメソッド http://railsdoc.com/references/validates_uniqueness_of
validates_uniqueness_of :sender_id, scope: :recipient_id
# 重複しないようチェックする仕組みとして送り主と受取人の「組み合わせ」で判定する
scope :between, -> (sender_id,recipient_id) do
  where("(conversations.sender_id = ? AND conversations.recipient_id =?) OR (conversations.sender_id = ? AND  conversations.recipient_id =?)", sender_id,recipient_id, recipient_id, sender_id)
end

  def target_user(current_user)
    if sender_id == current_user.id
      User.find(recipient_id)
    elsif recipient_id == current_user.id
      User.find(sender_id)
    end
  end
end
