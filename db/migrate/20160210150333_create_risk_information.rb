class CreateRiskInformation < ActiveRecord::Migration
  def change
    create_table :risk_information, id: :uuid, default: "uuid_generate_v4()" do |t|
      t.uuid      :escort_id
      t.boolean   :to_self
      t.text      :to_self_details
      t.boolean   :to_others
      t.text      :to_others_details
      t.boolean   :violence
      t.text      :violence_details
      t.boolean   :from_others
      t.text      :from_others_details
      t.boolean   :escape
      t.text      :escape_details
      t.boolean   :intolerant_behaviour
      t.text      :intolerant_behaviour_details
      t.boolean   :prohibited_items
      t.text      :prohibited_items_details
      t.boolean   :disabilities
      t.text      :disabilities_details
      t.boolean   :allergies
      t.text      :allergies_details
      t.boolean   :non_association
      t.text      :non_association_details

      t.timestamps null: false
    end
  end
end
