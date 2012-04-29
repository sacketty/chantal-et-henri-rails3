class AddUserIdToCategoriesSongs < ActiveRecord::Migration
  def change
    add_column :categories_songs, :user_id, :integer
  end
end
