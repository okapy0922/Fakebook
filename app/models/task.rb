# タスク機能のアソシエーション定義
class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :charge, class_name: 'User', foreign_key: 'charge_id' # タスクを抱えているタスク担当者を取得する
  validates :title, presence: true # validates :カラム名, presence: true　タスクのタイトルが空白で登録できないようにする設定
  enum status: {未着手:0, 対応中:1, 完了:2} # enumを使用して、表示させる値を変更する

  has_many :submit_requests, dependent: :destroy # タスクが削除されれば紐付くユーザ名も削除されるようにdependent: :destroyを設定
end
