module Pdf
  class PrisonerInformationPresenter
    def initialize(model)
      @model = model
    end

    delegate :family_name, :forenames, :prison_number, :nationality,
      :capitalized_sex, :date_of_birth, :age, :cro_number, :pnc_number,
      to: :@model

    delegate :day, :month, :year,
      to: :date_of_birth, prefix: true, allow_nil: true
  end
end
