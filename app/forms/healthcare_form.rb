class HealthcareForm < Form
  include Form::TextToggleAttribute

  text_toggle_attribute :physical_risk
  text_toggle_attribute :mental_risk
  text_toggle_attribute :social_care_and_other
  text_toggle_attribute :allergies
  text_toggle_attribute :disabilities

  attribute :mpv_required, Boolean
  attribute :medical_professional_name, String
  attribute :contact_telephone, String
  attribute :medication, MaybeBoolean
  attribute :medications, Array[MedicationForm],
    coercer: Form::MultiplesCoercer

  validates :medications, empty_medications: true
  validates :medications, invalid_medications: true

  def mpv_required
    super && disabilities
  end

  def carrier_options
    MedicationForm::CARRIER_TYPES.map do |c|
      [I18n.t("medication_form.carrier.#{c}"), c]
    end
  end

private

  def load_model_data
    super
    self.medications = target.backfilled_medications
  end

  def prepared_attributes_for_model
    attributes.dup.tap do |a|
      a[:medications_attributes] =
        a.delete(:medications).reject(&:empty?).map(&:attributes)
    end
  end

  def persist
    target.update_attributes(prepared_attributes_for_model)
    target.medications.destroy_all unless medication
    reload
  end
end
