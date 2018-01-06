# Relationshipモデルから見たUserモデルの参照関係を定義
class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
end

=begin

3行目のbelongs_to :follower, class_name: "User"
:followerという名前の参照関係を定義しています。
この時、外部キーとなるのは,「follower_id」でuser.rb側で（foreign_key: "follower_id"）と定義したためです。

また、class_name: "User"と指定することで参照関係先をUserモデル（usersテーブル）とすることができます。
指定しない場合、Railsは、 belongs_to :follower よりfollowerモデルを関係先とします。

Userモデル側の主キーは、アソシエーション定義時に明記しなければ、usersテーブルの「id」カラムに自動的になります。

=end

=begin

4行目のbelongs_to :followed, class_name: "User"
これにより、「:followed」という名前の参照関係を定義することができます。
外部キーとなるのはこっちも「follower_id」です。同じくuser.rb側で（foreign_key: "follower_id"）と定義したためです。

=end
