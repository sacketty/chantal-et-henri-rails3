class CreatePresences < ActiveRecord::Migration
  def change
    create_table :presences do |t|
      t.references :user
      t.boolean :mairie
      t.boolean :diner

      t.timestamps
    end
    add_index :presences, :user_id
  end
end
