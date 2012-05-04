class AddAddedByToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :added_by_id, :integer
  end
end
