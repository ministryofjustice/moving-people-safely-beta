class CreateOffenceDetails < ActiveRecord::Migration
  def change
    create_table :offence_details, id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
      t.uuid       :offences_id
      t.string     :offence_type
      t.string     :offence_status
      t.boolean    :not_for_release
      t.boolean    :current_offence
      t.timestamps null: false
    end
  end
end
