class CreateUserFollowings < ActiveRecord::Migration
  def change
    create_table :user_followings do |t|
      t.belongs_to :follower, index: true, foreign_key: true, null: false
      t.references :following, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
    add_index :user_followings, [:follower_id, :following_id], unique: true
  end
end
