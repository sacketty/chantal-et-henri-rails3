class AddColumnChambre2ToStatuts < ActiveRecord::Migration
  def change
    add_column :statuts, :chambre2, :integer
  end
end
