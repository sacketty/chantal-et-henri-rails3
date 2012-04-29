class AddKeyToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :key, :string
    add_index :songs, :key, :unique => true
  end
end
