class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.text :description
    end
    create_table :groups_users do |t|
      t.references :group
      t.references :user
    end
    add_index :groups_users, :group_id
    add_index :groups_users, :user_id
  end
end
