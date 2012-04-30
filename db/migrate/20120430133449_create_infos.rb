class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|
      t.string :subject
      t.text :text
      t.integer :author_id

      t.timestamps
    end
  end
end
