class CreateCategoriesSongs < ActiveRecord::Migration
  def change
    create_table :categories_songs do |t|
      t.integer :song_id
      t.integer :category_id
    end
    add_index :categories_songs, :song_id
    add_index :categories_songs, :category_id
  end
end
