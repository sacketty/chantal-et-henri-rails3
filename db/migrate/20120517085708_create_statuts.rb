class CreateStatuts < ActiveRecord::Migration
  def change
    create_table :statuts do |t|
      t.integer :user_id
      t.integer :mairie
      t.integer :diner
      t.integer :chambre

      t.timestamps
    end
  end
end
