class CreateSongsUsers < ActiveRecord::Migration
  def change
    create_table :songs_users do |t|
      t.integer :song_id
      t.integer :user_id
    end
    add_index :songs_users, :song_id
    add_index :songs_users, :user_id
  end

end
