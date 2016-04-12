module Pdf
  class PrisonerPresenter
    def initialize(model)
      @model = model
    end

    delegate :prison_number, :nationality, :capitalized_sex,
      :date_of_birth, :age, :cro_number, :pnc_number,
      to: :@model

    delegate :day, :month, :year,
      to: :date_of_birth, prefix: true, allow_nil: true

    def names
      [@model.family_name, @model.forenames].reject(&:blank?).join(' \ ')
    end
  end
end
