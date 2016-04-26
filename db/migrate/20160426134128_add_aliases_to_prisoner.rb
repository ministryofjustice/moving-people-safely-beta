class AddAliasesToPrisoner < ActiveRecord::Migration
  def change
    add_column :prisoners, :has_aliases, :boolean
    add_column :prisoners, :aliases, :string, array: true, default: []
  end
end
