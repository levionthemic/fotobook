class CreateNotifications < ActiveRecord::Migration[8.0]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true          # người nhận
      t.references :notifier, null: false, foreign_key: { to_table: :users } # người tạo
      t.references :notifiable, polymorphic: true, null: false
      t.string :action, null: false
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
