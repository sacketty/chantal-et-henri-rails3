class AddTypeAndInvitedByIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :type, :string
    add_column :users, :invited_by_id, :integer
    add_column :users, :myself, :boolean
    add_index :users, :invited_by_id
  end
end
