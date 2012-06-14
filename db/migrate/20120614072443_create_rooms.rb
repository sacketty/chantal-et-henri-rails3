class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.references :user
      t.string :number
      t.integer :places
      t.string :type

      t.timestamps
    end
    add_index :rooms, :user_id
  end
end
