class AddTableIdToGuests < ActiveRecord::Migration
  def change
    add_column :users, :table_id, :integer
    add_index :users, :table_id
  end
end
