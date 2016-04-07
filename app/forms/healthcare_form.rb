class HealthcareForm < Form
  include Form::TextToggleAttribute

  text_toggle_attribute :physical_risk
  text_toggle_attribute :mental_risk
  text_toggle_attribute :social_care_and_other
  text_toggle_attribute :allergies
  text_toggle_attribute :disabilities
  text_toggle_attribute :medication

  attribute :mpv_required, Boolean
  attribute :medical_professional_name, String
  attribute :contact_telephone, String

  def mpv_required
    super && disabilities
  end

  def target
    super.health_information
  end
end
