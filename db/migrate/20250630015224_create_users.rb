class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :first_name, null: false, limit: 25
      t.string :last_name, null: false, limit: 25
      t.string :email, null: false, limit: 255
      t.string :encrypted_password, null: false, default: ""
      t.integer :role, null: false, default: 1
      t.integer :status, null: false, default: 0
      t.string :avatar
      t.datetime :confirmed_at

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
