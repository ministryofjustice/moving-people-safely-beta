module Pdf
  class PrisonerInformationPresenter < SimpleDelegator
    def initialize(model)
      @model = model

      # TODO: We will not rely on the summary presenter for
      # PDFs. Rather than have a single model with adapters
      # for each section in the digital & corresponding PDF
      # form we will push some of the specifics to the model
      # layer.

      prisoner_info = ::PrisonerInformationPresenter.new(model)
      super(prisoner_info)
    end

    delegate :day, :month, :year,
      to: :date_of_birth, prefix: true, allow_nil: true

  private

    def date_of_birth
      @model.date_of_birth
    end
  end
end
