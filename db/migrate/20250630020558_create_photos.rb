class CreatePhotos < ActiveRecord::Migration[8.0]
  def change
    create_table :photos do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false, limit: 140
      t.text :description, null: false, limit: 300
      t.string :image, null: false
      t.integer :sharing_mode, null: false, default: 0

      t.timestamps
    end
  end
end
