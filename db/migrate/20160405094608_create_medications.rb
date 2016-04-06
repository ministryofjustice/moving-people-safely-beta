class CreateMedications < ActiveRecord::Migration
  def change
    create_table :medications, id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
      t.uuid     :healthcare_id
      t.text     :description
      t.text     :administration
      t.string   :carrier

      t.timestamps null: false
    end
  end
end
