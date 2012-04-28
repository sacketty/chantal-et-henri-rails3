class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :uid
      t.string :provider
      t.string :email
      t.string :name
      t.string :nickname
      t.string :first_name
      t.string :last_name
      t.string :image
      t.string :location
      t.boolean :admin
      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
