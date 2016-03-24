module Pdf
  class NotForReleasePresenter
    include CheckboxClass

    def initialize(model)
      @model = model
    end

    delegate :not_for_release_details, to: :@model

    def not_for_release_class
      checked_class_for(@model.not_for_release)
    end
  end
end
