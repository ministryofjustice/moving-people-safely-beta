module Pdf
  class PrisonerPresenter
    def initialize(model)
      @model = model
    end

    delegate :prison_number, :family_name, :forenames, :nationality,
      :capitalized_sex, :date_of_birth, :age, :cro_number, :pnc_number,
      :base_64_image, to: :@model

    delegate :day, :month, :year,
      to: :date_of_birth, prefix: true, allow_nil: true
  end
end
