class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_hash
      t.string :password_salt
      t.string :password
      t.string :password_confirmation
      t.integer :permission_level
      t.string :name
      t.string :avatar
      t.text :signature
      t.integer :points

      t.timestamps
    end
  end
end
