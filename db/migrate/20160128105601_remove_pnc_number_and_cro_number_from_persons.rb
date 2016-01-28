class RemovePncNumberAndCroNumberFromPersons < ActiveRecord::Migration
  def change
    remove_column :people, :pnc_number
    remove_column :people, :cro_number
  end
end
