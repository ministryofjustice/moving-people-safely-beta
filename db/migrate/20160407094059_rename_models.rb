class RenameModels < ActiveRecord::Migration
  def change
    rename_table :health_information, :healthcare
    rename_table :offence_information, :offences
    rename_table :risk_information, :risks
  end
end
