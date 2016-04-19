class RemoveMedicationDetailsFromHealthcare < ActiveRecord::Migration
  def change
    remove_column :healthcare, :medication_details
  end
end
