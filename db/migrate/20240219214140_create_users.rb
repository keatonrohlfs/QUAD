class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :password_digest, null: false
      t.string :email, null: false
      t.string :phone_number, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.datetime :confirmed_at
      t.datetime :datetime
      # t.integer :graduation_year
      # t.string :sorority
      # t.string :social_media, null: false
      # t.string :profile_picture, null: false

      t.timestamps
    end
    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
  end
end
