class ChangePrisonerDetailsAliasesToText < ActiveRecord::Migration
  def change
    change_column :prisoners, :aliases, :text
    remove_column :prisoners, :has_aliases
  end
end
