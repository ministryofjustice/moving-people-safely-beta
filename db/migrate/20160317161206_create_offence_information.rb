class CreateOffenceInformation < ActiveRecord::Migration
  def change
    create_table :offence_information, id: :uuid, default: "uuid_generate_v4()" do |t|
      t.uuid      :escort_id
      t.boolean   :not_for_release
      t.text      :not_for_release_details
      t.boolean   :must_return
      t.text      :must_return_details
      t.boolean   :must_not_return
      t.text      :must_not_return_details
      t.boolean   :other_offences
      t.text      :other_offences_details

      t.timestamps null: false
    end
  end
end
