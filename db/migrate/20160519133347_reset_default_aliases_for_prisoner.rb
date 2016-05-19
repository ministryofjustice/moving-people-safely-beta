class ResetDefaultAliasesForPrisoner < ActiveRecord::Migration
  def change
    change_column_default :prisoners, :aliases, nil
  end
end
