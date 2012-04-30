class AddUploadIdToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :upload_id, :integer
  end
end
