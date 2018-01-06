class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps null: false
    end
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    # ユーザを二度とフォローできないようにする、「ユニーク制約を付与する」「Uniqueインデックスを設定する」というらしい
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end
