module Pdf
  class NotForReleasePresenter
    def initialize(model)
      @model = model
    end

    delegate :not_for_release_details, to: :@model

    def not_for_release_class
      if @model.not_for_release
        Pdf::HtmlClasses.checked
      end
    end
  end
end
