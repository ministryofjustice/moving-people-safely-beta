class RemoveFieldsFromRiskInformation < ActiveRecord::Migration
  def change
    remove_column :risk_information, :to_others, :boolean
    remove_column :risk_information, :to_others_details, :text
    remove_column :risk_information, :disabilities, :boolean
    remove_column :risk_information, :disabilities_details, :text
    remove_column :risk_information, :allergies, :boolean
    remove_column :risk_information, :allergies_details, :text
  end
end
