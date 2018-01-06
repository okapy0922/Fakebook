class SubmitRequest < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  #タスク依頼 リクエスト先のユーザーを取得する
  # class_name: 'User', foreign_key: 'request_user_id'
  # request_user_idを外部キーにしてアソシエーションを定義
  belongs_to :request_user, class_name: 'User', foreign_key: 'request_user_id'
  # タスク依頼についてのバリデーションで定義
  validates :user_id, :task_id, :request_user_id, presence: true
  # タスク依頼が重複しないようにする
  # on: :createオプション: 依頼を追加した場合のみ、validationが発動し依頼重複を防ぐ
  validate :no_repeated_request, on: :create

    private

      def no_repeated_request
        submit_request = SubmitRequest.where(task_id: task_id, status: 1)
        # errors.add(:base, "このタスクは既に依頼をだしています。") unless submit_request.blank?で既に依頼されていた場合、バリデーションエラーが発生する。
        errors.add(:base, "このタスクは既に依頼をだしています。") unless submit_request.blank?
      end
end
