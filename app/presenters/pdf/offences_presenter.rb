module Pdf
  class OffencesPresenter
    include CheckboxClass

    def initialize(model)
      @model = model
    end

    delegate :must_return_details, :must_not_return_details, :offence_details,
      to: :@model

    def must_return_class
      checked_class_for(@model.must_return)
    end

    def must_not_return_class
      checked_class_for(@model.must_not_return)
    end

    def not_for_release_class(offence_details)
      checked_class_for(offence_details.not_for_release)
    end

    def current_offence_class(offence_details)
      checked_class_for(offence_details.current_offence)
    end

    def offence_status(offence_details)
      if offence_details.offence_status.present?
        I18n.t("pdfs.offences.status.#{offence_details.offence_status}")
      end
    end
  end
end
