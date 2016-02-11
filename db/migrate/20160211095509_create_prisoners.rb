class CreatePrisoners < ActiveRecord::Migration
  def change
    create_table :prisoners, id: :uuid, default: "uuid_generate_v4()" do |t|
      t.uuid   :escort_id
      t.string :family_name
      t.string :forenames
      t.date   :date_of_birth
      t.string :sex
      t.string :prison_number
      t.string :nationality

      t.timestamps null: false
    end
  end
end
