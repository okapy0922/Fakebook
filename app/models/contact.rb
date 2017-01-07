class Contact < ActiveRecord::Base
  validates :name, presence: true#バリデーションの実行（空白の値の更新を禁止）
  validates :email, presence: true#バリデーションの実行（空白の値の更新を禁止）
  validates :content, presence: true#バリデーションの実行（空白の値の更新を禁止）
end
