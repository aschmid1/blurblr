class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles, id: false do |t|
      t.belongs_to :user, foreign_key: true, null: false
      t.string :username, null: false
      t.string :fullname
      t.text :bio
      t.string :website

      t.timestamps null: false
    end
    add_index :user_profiles, :user_id, unique: true
    add_index :user_profiles, :username, unique: true
  end
end
