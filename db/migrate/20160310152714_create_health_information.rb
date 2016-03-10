class CreateHealthInformation < ActiveRecord::Migration
  def change
    create_table :health_information, id: :uuid, default: "uuid_generate_v4()" do |t|
      t.uuid   :escort_id
      t.boolean :physical_risk
      t.text :physical_risk_details
      t.boolean :mental_risk
      t.text :mental_risk_details
      t.boolean :social_care_and_other
      t.text :social_care_and_other_details
      t.boolean :allergies
      t.text :allergies_details
      t.boolean :disabilities
      t.boolean :mpv_required
      t.text :disabilities_details
      t.boolean :medication
      t.text :medication_details
      t.string :medical_professional_name
      t.string :contact_telephone

      t.timestamps null: false
    end
  end
end
