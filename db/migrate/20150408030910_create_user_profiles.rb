class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.belongs_to :user, index: true, foreign_key: true, null: false
      t.string :username, null: false
      t.string :fullname
      t.text :bio
      t.string :website

      t.timestamps null: false
    end
    add_index :user_profiles, :username, unique: true
  end
end
