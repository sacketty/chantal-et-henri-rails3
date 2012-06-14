class CreateListeMariages < ActiveRecord::Migration
  def change
    create_table :liste_mariages do |t|
      t.string :article
      t.boolean :taken
      t.references :taken_by

      t.timestamps
    end
    add_index :liste_mariages, :taken_by_id
  end
end
