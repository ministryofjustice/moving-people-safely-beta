class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.uuid :escort_id, index: true, foreign_key: true
      t.string :prison_number
      t.string :family_name
      t.string :forenames
      t.date :date_of_birth
      t.string :sex
      t.string :nationality
      t.string :pnc_number
      t.string :cro_number

      t.timestamps null: false
    end
  end
end
