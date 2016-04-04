module Pdf
  class OffencesPresenter
    include CheckboxClass

    def initialize(model)
      @model = model
    end

    delegate :must_return_details, :must_not_return_details,
      :other_offences_details, to: :@model

    def must_return_class
      checked_class_for(@model.must_return)
    end

    def must_not_return_class
      checked_class_for(@model.must_not_return)
    end
  end
end
