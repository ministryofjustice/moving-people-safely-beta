module Pdf
  class HealthcarePresenter
    include CheckboxClass

    def initialize(model)
      @model = model
    end

    delegate :physical_risk_details, :mental_risk_details,
      :social_care_and_other_details, :allergies_details, :mpv_required,
      :disabilities_details, :backfilled_medications,
      :medical_professional_name, :contact_telephone, to: :@model

    def mpv_required_class
      checked_class_for(@model.mpv_required)
    end

    def no_medication_class
      checked_class_for(@model.medication == false)
    end

    def carrier_class(value, field)
      checked_class_for(value == field)
    end
  end
end
