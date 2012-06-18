class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.references :to
      t.string :cc
      t.string :cci
      t.string :subject
      t.text :text

      t.timestamps
    end
    add_index :emails, :to_id
  end
end
