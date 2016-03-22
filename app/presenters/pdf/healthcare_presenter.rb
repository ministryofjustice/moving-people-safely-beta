module Pdf
  class HealthcarePresenter
    def initialize(model)
      @model = model
    end

    delegate :physical_risk_details, :mental_risk_details,
      :social_care_and_other_details, :allergies_details, :mpv_required,
      :disabilities_details, :medication_details, :medical_professional_name,
      :contact_telephone, to: :@model

    def mpv_required_class
      if @model.mpv_required
        CHECKED
      end
    end
  end
end
