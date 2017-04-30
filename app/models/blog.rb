class Blog < ActiveRecord::Base
  validates :title, presence: true#バリデーションの実行（空白の値の更新を禁止）
  validates :content, presence: true#バリデーションの実行（空白の値の更新を禁止）
  belongs_to :user
  end
