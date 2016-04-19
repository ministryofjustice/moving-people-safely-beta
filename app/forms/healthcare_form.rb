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
  attribute :medications, Array[MedicationForm]

  validates :medications, empty_medications: true
  validates :medications, invalid_medications: true

  def medications
    super || []
  end

  def medications=(input)
    super(prepare_incoming_medications(input))
  end

  def mpv_required
    super && disabilities
  end

  def backfilled_medications
    target.backfilled_medications(medications)
  end

  def carrier_options
    MedicationForm::CARRIER_TYPES.map do |c|
      [I18n.t("medication_form.carrier.#{c}"), c]
    end
  end

private

  def prepare_incoming_medications(input)
    input.is_a?(Hash) ? input.values : input.map(&:attributes)
  end

  def prepared_attributes_for_model
    attributes.tap do |a|
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
