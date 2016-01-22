class ChangeEscortRecordToEscort < ActiveRecord::Migration
  def change
    rename_table :escort_records, :escorts
  end
end
