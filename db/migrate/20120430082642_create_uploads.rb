class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :key
      t.string :titre
      t.string :artiste

      t.timestamps
    end
  end
end
