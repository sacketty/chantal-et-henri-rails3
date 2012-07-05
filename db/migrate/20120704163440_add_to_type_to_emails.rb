class AddToTypeToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :to_type, :string
  end
end
