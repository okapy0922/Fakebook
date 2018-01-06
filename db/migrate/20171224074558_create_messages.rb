# モデルと一緒にテーブルとカラムを指定して作成するコマンド
# コンソール実行 $ rails g model Message body:text conversation:references user:references read:boolean
class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      # text型カラム
      t.text :body
      # refarences型カラム
      t.references :conversation, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      # boolean データ型の一種で true(真) か false(偽) の値を管理する。
      # このカラムに nil（無） という余計な情報が入らないようにするために、デフォルト値「default: false」を指定して設定
      t.boolean :read, default: false

      t.timestamps null: false
    end
  end
end
