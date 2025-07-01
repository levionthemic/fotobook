class AddColumnsToAlbums < ActiveRecord::Migration[8.0]
  def change
    add_column :albums, :title, :string, null: false, limit: 140
    add_column :albums, :description, :text, null: false
    add_column :albums, :sharing_mode, :integer, null: false, default: 0
  end
end
