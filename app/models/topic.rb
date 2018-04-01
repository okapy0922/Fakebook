class Topic < ActiveRecord::Base
  # バリデーション追加、presence: trueで空白の投稿を禁止、エラーがでる
  validates :content, presence: true
  belongs_to :user
  has_many :comments, dependent: :destroy
  mount_uploader :image, AvatarUploader
end
