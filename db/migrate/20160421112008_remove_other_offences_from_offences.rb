class RemoveOtherOffencesFromOffences < ActiveRecord::Migration
  def change
    remove_column :offences, :other_offences, :boolean
    remove_column :offences, :other_offences_details, :text
  end
end
