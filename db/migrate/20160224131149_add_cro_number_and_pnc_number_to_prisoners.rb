class AddCroNumberAndPncNumberToPrisoners < ActiveRecord::Migration
  def change
    add_column :prisoners, :cro_number, :string
    add_column :prisoners, :pnc_number, :string
  end
end
