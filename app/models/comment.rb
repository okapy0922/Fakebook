class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :blog
  # アソシエーションの設定 コメントが複数の通知を持つことを定義
  has_many :notifications
end
