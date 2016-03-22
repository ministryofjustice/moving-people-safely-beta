module Pdf
  class OffencesPresenter
    def initialize(model)
      @model = model
    end

    delegate :other_offences_details, to: :@model
  end
end
