class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :image
      t.text :content
      t.timestamps null: false
      t.integer :user_id
    end
  end
end
