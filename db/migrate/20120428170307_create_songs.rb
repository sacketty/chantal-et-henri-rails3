class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.integer :uid
      t.string :titre
      t.string :artiste
      t.string :url

      t.timestamps
    end
    add_index :songs, :titre
  end
end
